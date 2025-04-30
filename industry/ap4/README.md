# README

The two folders contain matrices (SR matrices and emission matrices).

Code is in .m format.

NETL_AP4_Control_Script runs everything.

1.  Uploads AP4 baseline for the 2020 NEI.
2.  Computes baseline PM<sub>2.5</sub> concentrations.
3.  Calibrates estimates to the monitor data (coefficients applied from offline calibration).

The CSV files are broken down by source type and pollutant.

The code runs concentration calculations for the matrices formatted into cell arrays (multi-dimensional matrices).
Depending on how user's software works, the matrices may need to be reassembled into arrays.
The two concentration scripts will demonstrate how to assemble to invoke existing code.

A third zip file, Info_Matrices.zip, was created containing the source inventories for each industry/pollutant.
The first column in each of these files is the county FIPS ID.
The second is the Facility_ID from the NEI.

# NOTES

The data structures that are read by Load_Workspace.m are in PM2.5_Base_Concentration and should be items in the Matrices folder.

Overview of data files.

There are 97 CSV files. Emissions for 5 criteria air pollutants across EGU, G, and PNEGU (16 files). Then, there are SRM files for five CAPs across EGU, G, and PNEGU (16 files). Lastly, there are SRM files for five CAPs for each NAICS code (65).

-   Matrices/
    -   Emissions\_\*.csv
        -   The Emissions files are columnar.
        -   There are five chemistries: NH3, NOx, PMP, SO2, VOC
        -   There are three categories: G (ground), PNEGU (point non-EGU), and EGU.
        -   EGU has 1814 rows, 1 column. G has 3108 rows, 1 column. PNEGU has 3108 rows, 1 column.
-   Info_Matrices/

Overview of program: NETL_AP4_Control_Script.m

1.  Load_Workspace.m (TBD)
    a.  SR_Matrices_Ground
        i.  Likely a 6x1 set.
        ii. Index (5,1) has 2194 columns
        iii. Index (1,1) used to update NH3
        iv. Index (2,1) used to update HNO3
        v.  Index (3,1) used to update PMP
        vi. Index (4,1) used to update SO4
        vii. Index (5,1) used to update VOC
        viii. Index (6,1) used to update VOC_B
    b.  Emissions_2020_NEI
        i.  Likely a (3,1) set. Units are likely short tons.
        ii. Index (1,1) is Ground emissions and is an Nx6 matrix
            1.  Column 1 used to update NH3
            2.  Column 2 used to update HNO3
            3.  Column 3 used to update PMP
            4.  Column 4 used to update SO4
            5.  Column 5 used to update VOC
            6.  Column 6 used to update VOC_B
        iii. Index (2,1) is non-EGU point source emissions
        iv. Index (3,1) is EGU emissions
    c.  SR_Matrices_Point_Non_EGU
        i.  5x1 set
    d.  SR_Matrices_Point_EGU
        i.  5x1 set
2.  Calibration_Coefficients.m (define scalars)
    a.  PMP_Cal_base
    b.  SO2_Cal_base
    c.  NOx_Cal_base
    d.  NH3_Cal_base
    e.  VOC_Cal_base
    f.  VOC_B_Cal_base
3.  Calibration_Secondary_and_Tertiary.m
    a.  Define scalars
        i.  ratio
    b.  Turn scalars into matrices
        i.  PMP_Cal_base (1x3108)
        ii. VOC_Cal_base (1x3108)
    c.  Update matrix
        i.  SR_Matrices_Ground
4.  PM_25_Base_Concentration.m
    a.  Calculate base emissions. These appear to be matrices with three columns (1: Ground; 2: non-EGU; 3: EGU)
        i.  NH3
        ii. PMP (µg/m^3^)
        iii. HNO3
        iv. SO4
        v.  VOC (µg/m^3^)
        vi. VOC_B (µg/m^3^)
    b.  Update ground, non-EGU, and EGU emissions
5.  Nitrate_Sulfate_Ammonium_Update.m
    a.  Calculate vector totals (3108,1)
        i.  NH4_Total (molar concentrations)
        ii. SO4_Total (molar concentrations)
        iii. HNO3_Total (molar concentrations)
        iv. PMP_Total (mass concentrations)
        v.  VOC_Total (mass concentrations)
    b.  Calculate free ammonia vectors (3108, 1)
        i.  SO4_PM
        ii. NH4e
    c.  Calculate baseline particulate nitrate vector (3108, 1)
        i.  NO3_PM
        ii. NH4_NO3
        iii. NH4_2_SO4
    d.  Assemble total PM
        i.  PM_25 (3108x1 vector or matrix); units of µg/m^3^
        ii. PM_Spec (matrix)
6.  PM_25_Base_Concentration.m
    a.  Store data
        i.  PM_25_Base (3108x1 vector); units of µg/m^3^
        ii. HNO3_Base (3108x1 vector)
        iii. NH4e_Base (3108x1 vector)
7.  NETL_AP4_Industrial_Source_Matrix_Import.m
    a.  Create a series of 5x1 sets for each NAICS code in order of: NH3, NOx, PM25-PRI, SO2, and VOC, and read in data from files.
        i.  NAICS_322110
        ii. NAICS_3221201
        iii. NAICS_322130
        iv. NAICS_325120
        v.  NAICS_325180
        vi. NAICS_325193
        vii. NAICS_325311
        viii. NAICS_327310
        ix. NAICS_331110
        x.  NAICS_331511
        xi. NAICS_331512
        xii. NAICS_331513
        xiii. NAICS_NG
8.  NETL_AP4_PM25_Concentration_Script.m
    a.  Initialize set for industrial sources. 13x5 (13 NAICS and 5 pollutants)
        i.  Industrial_Source_Emissions
    b.  Appears to overwrite NH3, HNO3, PMP, SO4, and VOC, which become (Nx13) matrices.
    c.  Assemble industrial concentrations (columnar additional; not sure what the row count will be, maybe the max of all columns); appear to single column vectors
        i.  NH3_Industrial
        ii. VOC_Industrial
        iii. SO4_Industrial
        iv. HNO3_Industrial
        v.  PMP_Industrial
9.  NETL_AP4_Nitrate_Sulfate_Ammonium_Update.m
    a.  Run unit conversions (overwrite the previous versions)
        i.  NH4_Total
        ii. SO4_Total
        iii. HNO3_Total
        iv. PMP_Total
        v.  VOC_Total
    b.  Same calculations
    c.  Calculate total PM25
        i.  PM_25_Industrial
        ii. PM_Spec (overwrites previous)
10. NETL_AP4_Clean_Up.m
    a.  Looks like a copy and paste from somewhere else (e.g., AP4_EGU_List is not a variable that I see, which is being cleared here)

# QUESTIONS

What are the units of CSV files?

What to do with Industrial_Source_Emissions matrix cell?
It was originally all zeros, which did nothing.
I changed it to ones, but seems like the units are smaller than expected.
For example, is one a ton?
I don't think so.
