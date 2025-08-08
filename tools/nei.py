#!/usr/bin/env python3
# -*- coding=utf-8 -*-
#
# nei.py
#
# Take industry AP4 (2024) facility data (Info_Matrices), find its
# location (via USEPA's StEWI), include AP4 (2023, county version)
# EGU data.

#
# REQUIRED PACKAGES
#
from glob import glob
import os
import re

import geopandas as gpd
import matplotlib.pyplot as plt
import pandas as pd

import stewi

#
# GLOBALS
#
# The info matrix data and a place for the previous version's EGU list.
data_dir = os.path.join("..", "industry", "ap4", "Info_Matrices")
other_dir = os.path.join("..", "industry", "ap4", "Other")

#
# FUNCTIONS
#
def add_naics_code(fac_id, fac_dict):
    # Send a facility ID (fac_id) and the NAICS dictionary (fac_dict)
    r_code = ""
    for n_code in fac_dict:
        if fac_id in fac_dict[n_code]:
            r_code = n_code
            break
    return r_code


def cleanup_egu(df):
    df = df.rename(columns={
        'fips': 'FIPS',
        'eis': "FacilityID",
        'name': 'Site',
        'lon': 'Lon',
        'lat': 'Lat',
    })
    df = df.drop(columns=['row', 'orispl'])
    nei_crit = df['nei_2017'] == 'Yes'
    df = df.loc[nei_crit, :]
    df = df.drop(columns='nei_2017')
    df['NAICS'] = 'Electric Power Generation'
    df['NAICS_Code'] = '2211'

    return df


#
# MAIN
#
# Read EGU data from 2023 AP4 Excel file (using 2017 NEI)
#   Includes facility ID, lat, lon data; add NAICS for electricity generators
#   Available on EDX, https://edx.netl.doe.gov/resource/8e700830-84ef-431e-b301-9552b0f61f0a/download
egu_file = os.path.join(other_dir, 'egu_list.csv')
egu_df = pd.read_csv(egu_file)
egu_df = cleanup_egu(egu_df)

# Get the info matrix CSV files
all_files = glob(os.path.join(data_dir, "*.csv"))

# find the NAICS codes from the info files
p = re.compile('Info_\\w{3,4}_(\\d+)\\.csv')
naics = []
for info_file in all_files:
    base_name = os.path.basename(info_file)
    r = p.search(base_name)
    if r:
        n_code = r.group(1)
        if n_code not in naics:
            naics.append(n_code)
naics = sorted(naics)

# Build a map of NAICS code to industry
# https://www.naics.com/code-search/
n_code_map = {
    'NG': "Amine Gas Processing",
    '322110': "Pulp Mills",
    '3221201': "Paper Mills",
    '322130': "Paperboard Mills",
    '325120': "Industrial Gas Manufacturing",
    '325180': "Other Basic Inorganic Chemical Manufacturing",
    '325193': "Ethyl Alcohol Manufacturing",
    '325311': "Nitrogenous Fertilizer Manufacturing",
    '327310': "Cement Manufacturing",
    '331110': "Iron and Steel Mills and Ferroalloy Manufacturing",
    '331511': "Iron Foundries",
    '331512': "Steel Investment Foundries",
    '331513': "Steel Foundries",
}

# Find facilities associated with each naics
naics_dict = {}
for n_code in naics + ['NG',]:
    naics_dict[n_code] = []
    p = re.compile('Info_\\w{3,4}_%s\\.csv' % n_code)
    for info_file in all_files:
        base_name = os.path.basename(info_file)
        r = p.search(base_name)
        if r:
            # Found a CSV file associated with the naics; read it
            tmp_df = pd.read_csv(
                info_file, usecols=[0,1], skiprows=1, header=None)
            tmp_df.columns = ['fips', 'facility']
            tmp_df = tmp_df.dropna()
            # Pull the facility IDs and add any new Ids to the list
            n_list = tmp_df['facility'].to_list()
            for n in n_list:
                if n not in naics_dict[n_code]:
                    naics_dict[n_code].append(n)

# Table 1 for AGU (2024) poster
if False:
    table1_csv = os.path.join(other_dir, "table_naics_agu24.csv")
    pd.DataFrame({
        'NAICS': [n_code_map[x] for x in sorted(list(naics_dict.keys()))],
        'NAICS_Code': [x for x in sorted(list(naics_dict.keys()))],
        'COUNT': [len(naics_dict[x]) for x in sorted(list(naics_dict.keys()))],
    }).to_csv(tabe1_csv, index=False)

# Get a list of all 1254 industry facilities
industry_ids = []
for n_list in naics_dict.values():
    for n in n_list:
        if n not in industry_ids:
            industry_ids.append(n)

# Import NEI facility data; thanks StEWI!
# NOTE: facility ID is a string!
n20_df = stewi.getInventoryFacilities("NEI", 2020, True)
n17_df = stewi.getInventoryFacilities("NEI", 2017, True)

# Create a data frame with industry facility location and NAICS data
missing_ids = []
ind_df = pd.DataFrame(columns=['FacilityID', 'NAICS_Code', 'Lon', 'Lat'])
for ind in industry_ids:
    tmp_df = n20_df.query("FacilityID == '%d'" % ind)
    tmp2 = n17_df.query("FacilityID == '%d'" % ind)
    if len(tmp_df) == 1:
        to_add = {
            'FacilityID': [ind,],
            'Lat': [float(tmp_df['Latitude'].values[0]), ],
            'Lon': [float(tmp_df['Longitude'].values[0]), ],
            'NAICS_Code': [add_naics_code(ind, naics_dict), ],
        }
        if len(ind_df) == 0:
            ind_df = pd.DataFrame(to_add)
        else:
            ind_df = pd.concat(
                [ind_df, pd.DataFrame(to_add)], ignore_index=True)
    elif len(tmp2) == 1:
        to_add = {
            'FacilityID': [ind,],
            'Lat': [float(tmp2['Latitude'].values[0]), ],
            'Lon': [float(tmp2['Longitude'].values[0]), ],
            'NAICS_Code': [add_naics_code(ind, naics_dict), ],
        }
        if len(ind_df) == 0:
            ind_df = pd.DataFrame(to_add)
        else:
            ind_df = pd.concat(
                [ind_df, pd.DataFrame(to_add)], ignore_index=True)
    else:
        missing_ids.append(ind)

# Simplify the NAICS code plotting with these general categories
# https://www.naics.com/six-digit-naics/?v=2017&code=31-33
# https://www.naics.com/six-digit-naics/?v=2020&code=31-33
naics_simple_map = {
    'NG': "Amine Gas Processing",
    '322110': "Pulp, Paper & Paperboard Mills",
    '3221201': "Pulp, Paper & Paperboard Mills",
    '322121' : "Pulp, Paper & Paperboard Mills",
    '322130': "Pulp, Paper & Paperboard Mills",
    '325120': "Basic Chemical Manufacturing",
    '325180': "Basic Chemical Manufacturing",
    '325193': "Basic Chemical Manufacturing",
    '325311': "Fertilizer Manufacturing",
    '327310': "Cement Manufacturing",
    '331110': "Iron and Steel Mills and Ferroalloy Manufacturing",
    '331511': "Foundries",
    '331512': "Foundries",
    '331513': "Foundries",
}
ind_df['NAICS'] = ind_df['NAICS_Code'].map(naics_simple_map)


# Get US state-level shapefile (1:5M); drop non contiguous states/territories
# https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.2020.html#list-tab-1883739534
STATE_FILTER = ['PR', 'MP', 'AS', 'GU', 'VI', 'AK', 'HI']
shp_file = os.path.join(
    os.path.expanduser("~"),
    "Workspace",
    "ap4",
    "Shapes",
    "cb_2020_us_state_5m",
    "cb_2020_us_state_5m.shp"
)
us_df = gpd.read_file(shp_file)
us_df = us_df.loc[~us_df['STUSPS'].isin(STATE_FILTER), :]

us_crs = ('EPSG', us_df.crs.to_epsg())

# Make/read EGU geo data.
egu_geojson = os.path.join(other_dir, "egu.geojson")
if os.path.isfile(egu_geojson):
    egu_gdf = gpd.read_file(egu_geojson)
else:
    # Write shapefile for quick reading next time!
    egu_gdf = gpd.GeoDataFrame(
        egu_df,
        geometry=gpd.points_from_xy(egu_df.Lon, egu_df.Lat),
        crs='EPSG:4326',
    )
    egu_gdf.to_file(egu_geojson, driver="GeoJSON")
egu_gdf = egu_gdf.to_crs(us_crs)

# Make/read industry geo data.
ind_geojson = os.path.join(other_dir, "ind.geojson")
if os.path.isfile(ind_geojson):
    ind_gdf = gpd.read_file(ind_geojson)
else:
    # Make geo-data frames from points
    ind_gdf = gpd.GeoDataFrame(
        ind_df,
        geometry=gpd.points_from_xy(ind_df.Lon, ind_df.Lat),
        crs='EPSG:4326',  # WGS84
    )
    ind_gdf.to_file(ind_geojson, driver='GeoJSON')
ind_gdf = ind_gdf.to_crs(us_crs)

# Figure 1.
ax = us_df.plot(color='0.9', edgecolor='gray', linewidth=0.75)
egu_gdf.plot(ax=ax, color='gray', markersize=5, marker='+', aspect=1)
plt.show()

# Figure 2.
ax = us_df.plot(color='0.9', edgecolor='gray', linewidth=0.75)
ind_gdf.plot(ax=ax, column='NAICS', markersize=10, marker='o', aspect=1, legend=True, cmap='tab20b')
plt.show()
