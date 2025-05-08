#! /usr/bin/env python3
# -*- coding: utf-8 -*-
#
# ap4_geo.py
#
# Create a geoJSON file of U.S. counties for industry AP4 results (2024).
#
# The folders are organized as follows:
#
# - industry/ap4/
#   - Info_Matrices/
#   - Matrices/
#   - Outputs/  * here is where the PM25 results are located
# - electricity/ap4t/
#   - AP4_Tract_Inputs/ * here is where the county FIPS list CSV is located

import os

import pandas as pd
import geopandas as gpd
import requests


# GLOBALS
PCS = ('esri', 102009)
'''tuple : Geopandas CRS info for North America Lambert Conformal Conic.'''
SHAPES_DIR = "."
'''str : Where to save the ESRI shapefile ZIP.'''
STATE_FILTER = ['PR', 'MP', 'AS', 'GU', 'VI']
'''list : A list of state and territory codes to remove from census data.'''


# FUNCTIONS
def download_file(url, filepath):
    """Download a file from the web.

    Parameters
    ----------
    url : str
        A web address that points to a file.
    filepath : str
        A file path (including the file name) to where the local copy of the
        file should be downloaded.

    Returns
    -------
    bool
        Whether the requests download was successful.
    """
    r = requests.get(url)
    if r.ok:
        with open(filepath, 'wb') as f:
            f.write(r.content)

    return r.ok


def get_county_geo(year, region, make_prj=False):
    """Read US county shapefile for a given year and region.

    Notes
    -----

    Source: https://www2.census.gov/geo/tiger/GENZ2020/shp/

    Parameters
    ----------
    year : int
        The year to pull the geospatial data set.
        Valid years include 2020--2023.
    region : str
        The region code.
        If state, it's the state number (e.g., '54' is West Virginia).
        Note that state numbers less than 10 should be zero padded (e.g. '08').
        If U.S., use 'US'
    make_prj : bool, optional
        Whether to project the geometry to 2D using the PCS coordinate
        system (e.g., North America Lambert Conformal Conic).

    Returns
    -------
    geopandas.geodataframe.GeoDataFrame
        A geospatial data frame of polygon areas representing the U.S.
        counties, with columns,

        -   STATEFP (str), two digit state ID (zero padded)
        -   COUNTYFP (str), three digit county ID (zero padded)
        -   STUSPS (str), two-character state abbreviation
        -   STATE_NAME (str), state name
        -   STCO (str), unique state-county identification, found by combining
            STATEFP and COUNTYFP columns

    Raises
    ------
    OSError
        The zipped shapefile is not publicly accessible. This error raises
        when the local file is not found.

    Notes
    -----
    Based on NETL's Regionalizer code
    https://github.com/neTL-RIC/regionalizer
    """
    # Create the census file name, (e.g., "cb_2020_us_county_500k.zip")
    if isinstance(region, int):
        region = "%02d" % region
    region = region.lower()
    cen_file = "cb_%d_us_county_500k.zip"  % (year)
    cen_path = os.path.join(SHAPES_DIR, cen_file)

    # Handle missing census data files.
    if not os.path.isfile(cen_path):
        cen_url = "https://www2.census.gov/geo/tiger/GENZ%d/shp/%s" % (
            year, cen_file)
        _worked = download_file(cen_url, cen_path)
        if _worked:
            print("County shapefile downloaded!")

    gdf = gpd.read_file(cen_path)

    # Remove non-states from data frame
    gdf = gdf.query("STUSPS not in @STATE_FILTER")

    if make_prj:
        gdf = gdf.to_crs(PCS)

    keep_cols = [
        'GEOID',
        'STATEFP',
        'STUSPS',
        'STATE_NAME',
        'COUNTYFP',
        'NAMELSADCO',
        'geometry'
    ]
    drop_cols = [x for x in gdf.columns if x not in keep_cols]
    gdf = gdf.drop(columns=drop_cols)
    if region != 'us':
        gdf = gdf[gdf['STATEFP'] == region]

    return gdf


# County FIPS codes need converted to zero-padded strings for joining
def to_str(x):
    return "%05d" % x


# Define the folders
result_dir = os.path.join("..", "industry", "ap4", "Outputs")
input_dir = os.path.join("..", "electricity", "ap4t", "AP4_Tract_Inputs")

# Define the files
pm25_base_csv = "PM_25_Base.csv"
pm25_ind_csv = "PM_25_Industrial.csv"  # +1 ton for all NAICS codes
county_list_csv = "AP4_County_List.csv"

# Read data (note no column headers in CSV files)
county_geo = get_county_geo(2020, 'us', False)
county_fips = pd.read_csv(os.path.join(input_dir, county_list_csv), header=None)
pm25_base = pd.read_csv(os.path.join(result_dir, pm25_base_csv), header=None)
pm25_ind = pd.read_csv(os.path.join(result_dir, pm25_ind_csv), header=None)

# Fix column names
county_fips.columns = ["Index", "fcode"]
pm25_base.columns = ['PM25_base']
pm25_ind.columns = ['PM25_ind']

county_fips['FIPS'] = county_fips['fcode'].apply(to_str)

# Add FIPS codes to results; they are all in the correct order, use index
# What are the units? I think micrograms per cubic meter.
results = pd.merge(
    left=county_fips,
    right=pm25_base,
    left_index=True,
    right_index=True,
    how='left'
)
results = results.merge(
    right=pm25_ind,
    right_index=True,
    left_index=True,
    how='left'
)
results = results.drop(columns=['Index', 'fcode'])

# Merge the results with the geo data frame
county_geo = county_geo.merge(
    right=results,
    how='left',
    left_on='GEOID',
    right_on='FIPS'
)

# Drop counties without results
county_geo = county_geo.dropna(subset='FIPS')

# Save to GeoJSON
county_geo.to_crs(('epsg', 4326)).to_file('ap4.geojson', driver='GeoJSON')
