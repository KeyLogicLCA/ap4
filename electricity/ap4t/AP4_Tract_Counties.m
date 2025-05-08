%% County Model Scripts:
for f = 1:length(fips)
	run AP4_Tract_Setup                           
    run AP4_Tract_Marginal_Impacts_Ground         
    run AP4_Tract_Marginal_Impacts_Non_EGU_Point
    if sourced_by_county == "yes"
        run Sourced_by_County
    end
    run AP4_Tract_Outputs
end

%% end of script.