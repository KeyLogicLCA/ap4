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

1. Load_Workspace.m (TBD)
   * SR_Matrices_Ground
     * Likely a 6x1 set.
     * Index (5,1) has 2194 columns
     * Index (1,1) used to update NH3
     * Index (2,1) used to update HNO3
     * Index (3,1) used to update PMP
     * Index (4,1) used to update SO4
     * Index (5,1) used to update VOC
     * Index (6,1) used to update VOC_B
   * Emissions_2020_NEI
     * Likely a (3,1) set. Units are likely short tons.
     * Index (1,1) is Ground emissions and is an Nx6 matrix
       * Column 1 used to update NH3
       * Column 2 used to update HNO3
       * Column 3 used to update PMP
       * Column 4 used to update SO4
       * Column 5 used to update VOC
       * Column 6 used to update VOC_B
     * Index (2,1) is non-EGU point source emissions
     * Index (3,1) is EGU emissions
   * SR_Matrices_Point_Non_EGU
     * 5x1 set
   * SR_Matrices_Point_EGU
     * 5x1 set
2. Calibration_Coefficients.m (define scalars)
   * PMP_Cal_base
   * SO2_Cal_base
   * NOx_Cal_base
   * NH3_Cal_base
   * VOC_Cal_base
   * VOC_B_Cal_base
3. Calibration_Secondary_and_Tertiary.m
   * Define scalars
     * ratio
   * Turn scalars into matrices
     * PMP_Cal_base (1x3108)
     * VOC_Cal_base (1x3108)
   * Update matrix
     * SR_Matrices_Ground
4. PM_25_Base_Concentration.m
   * Calculate base emissions. These appear to be matrices with three columns (1: Ground; 2: non-EGU; 3: EGU)
     * NH3
     * PMP (µg/m^3^)
     * HNO3
     * SO4
     * VOC (µg/m^3^)
     * VOC_B (µg/m^3^)
   * Update ground, non-EGU, and EGU emissions
5. Nitrate_Sulfate_Ammonium_Update.m
   * Calculate vector totals (3108,1)
     * NH4_Total (molar concentrations)
     * SO4_Total (molar concentrations)
     * HNO3_Total (molar concentrations)
     * PMP_Total (mass concentrations)
     * VOC_Total (mass concentrations)
   * Calculate free ammonia vectors (3108, 1)
     * SO4_PM
     * NH4e
   * Calculate baseline particulate nitrate vector (3108, 1)
     * NO3_PM
     * NH4_NO3
     * NH4_2_SO4
   * Assemble total PM
     * PM_25 (3108x1 vector or matrix); units of µg/m^3^
     * PM_Spec (matrix)
6. PM_25_Base_Concentration.m
   * Store data
     * PM_25_Base (3108x1 vector); units of µg/m^3^
     * HNO3_Base (3108x1 vector)
     * NH4e_Base (3108x1 vector)
7. NETL_AP4_Industrial_Source_Matrix_Import.m
   * Create a series of 5x1 sets for each NAICS code in order of: NH3, NOx, PM25-PRI, SO2, and VOC, and read in data from files.
     * NAICS_322110
     * NAICS_3221201
     * NAICS_322130
     * NAICS_325120
     * NAICS_325180
     * NAICS_325193
     * NAICS_325311
     * NAICS_327310
     * NAICS_331110
     * NAICS_331511
     * NAICS_331512
     * NAICS_331513
     * NAICS_NG
8. NETL_AP4_PM25_Concentration_Script.m
   * Initialize set for industrial sources. 13x5 (13 NAICS and 5 pollutants)
     * Industrial_Source_Emissions
   * Appears to overwrite NH3, HNO3, PMP, SO4, and VOC, which become (Nx13) matrices.
   * Assemble industrial concentrations (columnar additional; not sure what the row count will be, maybe the max of all columns); appear to single column vectors
     * NH3_Industrial
     * VOC_Industrial
     * SO4_Industrial
     * HNO3_Industrial
     * PMP_Industrial
9. NETL_AP4_Nitrate_Sulfate_Ammonium_Update.m
   * Run unit conversions (overwrite the previous versions)
     * NH4_Total
     * SO4_Total
     * HNO3_Total
     * PMP_Total
     * VOC_Total
   * Same calculations
   * Calculate total PM25
     * PM_25_Industrial
     * PM_Spec (overwrites previous)
10. NETL_AP4_Clean_Up.m
    * Looks like a copy and paste from somewhere else (e.g., AP4_EGU_List is not a variable that I see, which is being cleared here)

# QUESTIONS

What are the units of CSV files?

What to do with Industrial_Source_Emissions matrix cell?
It was originally all zeros, which did nothing.
I changed it to ones, but seems like the units are smaller than expected.
For example, is one a ton?
I don't think so.
