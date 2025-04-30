# README

The two folders contain matrices (SR matrices and emission matrices).

Code is in .m format.

NETL_AP4_Control_Script runs everything.

1.  Uploads AP4 baseline for the 2020 NEI.
2.  Computes baseline PM~2.5~ concentrations.
3.  Calibrates estimates to the monitor data (coefficients applied from offline calibration).

The CSV files are broken down by source type and pollutant.

The code runs concentration calculations for the matrices formatted into cell arrays (multi-dimensional matrices).
Depending on how user's software works, the matrices may need to be reassembled into arrays.
The two concentration scripts will demonstrate how to assemble to invoke existing code.
