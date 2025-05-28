# Overview
The Air Pollution Emissions Experiments and Policy version 4 (AP4) reduced-form air quality model (RFM) was created by colleagues at Carnegie Mellon University (CMU) under the direction of N. Muller, PhD, and his graduate student L. Dennin, funded by the National Energy Technology Laboratory (2020&ndash;2024).

AP4 is a MATLAB program (built on AP3[^1]) that employs an RFM framework to analyze the marginal effects of air pollution throughout the contiguous United States at the county and census tract levels.
Users can adjust the emissions in any particular region by any amount, which allows for both the spatial distribution and the magnitude of damages to be analyzed (i.e., who is being impacted and by how much).
Marginal damages are determined by an increment in emissions of one (short) ton to a given baseline (e.g., 2002 observed emissions); the difference is the marginal damage per ton of pollutant from a selected source (there are approximately 10,000 sources in the United States).
Emissions data (provided by the US EPA) are converted from their reported units (tons per year) to source-receptor units (grams per source), where sources are the counties, electric generating units (EGUs) and industries or manufacturing plants.
Resulting ambient concentration estimates are in grams per cubic meter, which are converted to parts per billion and parts per million (ppb and ppm, respectively).

[^1]: Muller, N.Z. and R. Mendelsohn (2007) Measuring the damages of air pollution in the United States, _Journal of Environmental Economics and Management_, 54, 1&ndash;14.
