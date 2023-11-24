# GeoFind_SHC

Howdy Stranger!

__If__ you get here through an Apendix A link, 
  
    Then congratulations! You are at right place!

__Else__ 

    You may be lost in TimeSpace.
    This is an underconstruction space about an unpublished (yet) work. 
    Feel free to return in a few months when all the concepts will be stated and clear!

__Endif__

### Open repository for Geometric Search Scheduling Methodology for a Smar Home Controller

This work presents a new methodology to schedule home appliances in order to reduce the energy bill and maintain the user comfort when this variable is related to time shifting of the loads. By exploring some properties of Brazilian energy tariff we had decomposed the time axis into a geometric space in which the movement of loads through time could be mapped. Analytic analysis of this properties leaded us to find a specific point into the decomposed time space that assures relative lower cost and minimum load shifting. Benchmark trials in results section will show that the proposed methodology is about thousand times faster than classic algorithms used to solve this class of optimization problem and consumes substantially less memory resources that could lead to a future implementation into a small embedded system. 
[Future work abstract]

### GitHub files structure

All code here was written in Julia Language and severely tested in version 1.8.5. At date of 24/November/2023 all code were working as expected!

Code files can be found under __\src__ folder. Main file is [SHC.jl](/src/SHC.jl)

The __images__ folder has illustrations of:
- All MDPI article / UFC - POSDEE Theses figures. 
- Complementary Time Decompositon Process; See file name pattern in Figure 1 for more details.
- Scheduling Results for Scenario 1; As shown in Figure 2; This files use PU preffix related to original author's name.
- Scheduling results for Random Scenarios; As shown in Figure 3.
![Figure 1](/images/Load_0_Time.png) Figure 1
![Figure 2](/images/PU_Te.png) Figure 2
![Figure_3](/images/RND10_T0.png) Figure 3

Into scheduling results for random scenarios, the suffixes listed bellow indicate the methodology used to generate the graphic.

- Te suffix marks a scheduling related to user expected ON time
- T0 suffix marks GeoFind scheduling output
- T1 suffix marks MOA_Hierarchical scheduling output without demand restriction
- T2 suffix marks MOA_Hierarchical scheduling output with demand restriction
- T20 suffix marks MOA_Hierarchical scheduling output with demand restriction initializaded with GeoFind results
- T3 suffix marks Hybrid strategy scheduling output (comply with demand restriction)

The __data__ folder has *.bson files for all generated random load scenarios and also stores benchmark output results both in *.jl and *.bson files. See Figure 4 for a graphic tutorial.

![Figure 4](/data/BenchmarkOutput.png) Figure 4

### Best Regards and Have Fun!
