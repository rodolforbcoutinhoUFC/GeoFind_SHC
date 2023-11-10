module SHC

    # Add julia packages here
    using BenchmarkTools
    using BSON
    using Colors, ColorSchemes
    using DataFrames
    using Dates
    using GeometryBasics
    using GLMakie
    using LaTeXStrings
    using Plots
    #using StatsKit -- to heavy to keep included
    using Statistics
    using Distributions
    using TimeSeries
    
    using JuMP
    using Gurobi
        import HiGHS
        import MultiObjectiveAlgorithms as MOA
    
    Normal = Distributions.Normal
    plot = Plots.plot
    plot! = Plots.plot!
    
    # Add custom project functions in RAW mode here
    # Use this strategy to keep less code in each file, there is no need for new modules!!!
    include("LoadModel.jl")
	include("LoadScenarios.jl")

    include("ComfortModel.jl")
    include("EnergyAnalysis.jl")

	include("GeoFind.jl")

    include("Find_Demand_Peak.jl")
	include("JuMP_MOA.jl")
	
    
    """*********
    ### MAIN ###
    *********""" 

    function main()
        println("MAIN CODE WILL BE HERE")
    end

    #= this is here for copy and paste - do not call it from SHC
    using Pluto; Pluto.run(Pluto.Configuration.from_flat_kwargs(;run_notebook_on_load=false)) =#

	"""
	Define a new BasicLoad specifying directly its parameters
	"""
    function New_Load()
        #   r e d Δt C P(t)
        L = BasicLoad(Time(0),Time(18),Time(23,30),Time(0,30),Time(6),t->1)
        Pe,Vp,Cost = Eval_CostVector(L)
        Comf = Eval_ComfortVector(L)

        # Plot_BasicLoad(L,L.s[end]; load_name = ".max finish")
        # Plot_BasicLoad!(L,L.s[1]; load_name = ".rise", color = :blue)
        # Plot_BasicLoad!(L,L.e; load_name = ".expected", color = :orange)

        f = Generate_BasicLoad_TimeSpace(L.CΔ, L.Δt,  Pe, Vp, Cost)
        save("LOAD_6.png",f)
        return L,Pe,Vp,Cost,Comf
        #L,Pe,Vp,Cost,Comf = SHC.New_Load()
    end

	"""
	Eval most important parameters for a BasicLoad, Plot its TimeSpace and Geometry Locus
	"""
    function inspect_Load(L::BasicLoad)
        Pe,Vp,Cost = Eval_CostVector(L)
        Comf = Eval_ComfortVector(L)

        # Plot_BasicLoad(L,L.s[end]; load_name = ".max finish")
        # Plot_BasicLoad!(L,L.s[1]; load_name = ".rise", color = :blue)
        # Plot_BasicLoad!(L,L.e; load_name = ".expected", color = :orange)

        Generate_BasicLoad_TimeSpace(L.CΔ, L.Δt,  Pe, Vp, Cost)

        return L,Pe,Vp,Cost,Comf
        #L,Pe,Vp,Cost,Comf = SHC.New_Load()
    end

	"""
	H,T = RunRandomModel()
	Plot_BasicLoadArray_StackedLoads(H, T[:x]) where x is the time output related to each simulation case
	Plot_DemandPeak(H)
	OBS: to use BenchmarkTools functions should be run into REPL. Select it and press CTRL+ENTER
	"""
    function RunRandomModel(x::Int64)
        #x = 25
        #H = Load_BasicLoadArray("RND1000")
        H = Generate_BasicLoadArray(Time(0,5), x; max_load_power = 3.0)
        t0 = Best_GeoFindVector(H)
        Hcut, V = find_demand_peaks(H,t0)

        println("Running Model for $x Random Loads\n\n")

        println("Benchmarks for GeoFind")
        @time t0 = Best_GeoFindVector(H)
        ival = VTime2Vector(H, t0)
        #b0=@benchmark Best_GeoFindVector(H)
        comf = Eval_Global_Comfort(H, t0)
        cost = Eval_Global_Cost(H, t0)
        println("Mean Comfort = $comf, Mean NormCost = $cost\n\n")

        println("Benchmarks for MultiObjectiveAlgorithm = Hierarchical")
        @time t1 = JuMP_MOAVector(H)
        #b1=@benchmark JuMP_MOAVector(H)
        comf = Eval_Global_Comfort(H,t1)
        cost = Eval_Global_Cost(H,t1)
        println("Mean Comfort = $comf, Mean NormCost = $cost\n\n")

        println("Benchmarks for MultiObjectiveAlgorithm = Hierarchical with power demand constraint and StartValue at release time")
        @time t2 = JuMP_MOAVector(H; demand=true)
        #b2=@benchmark JuMP_MOAVector(H;demand=true)
        comf = Eval_Global_Comfort(H, t2)
        cost = Eval_Global_Cost(H, t2)
        println("Mean Comfort = $comf, Mean NormCost = $cost\n\n")

        println("Benchmarks for MultiObjectiveAlgorithm = Hierarchical with power demand constraint and StartValue = No demand Restriction")
        
        @time t20 = JuMP_MOAVector(H; demand=true, iVal=ival)
        #b20=@benchmark JuMP_MOAVector(H; demand=true, iVal=ival)
        comf = Eval_Global_Comfort(H, t20)
        cost = Eval_Global_Cost(H, t20)
        println("Mean Comfort = $comf, Mean NormCost = $cost\n\n")

        println("Benchmarks for Hybrid Strategy with power demand constraint and and StartValue at release time")

        @time t3,count = Hybrid(H; demand_scale = 0.95, max_iterations = 5)
        #b3=@benchmark Hybrid(H; demand_scale = 0.95, max_iterations = 5)
        comf = Eval_Global_Comfort(H, t3)
        cost = Eval_Global_Cost(H, t3)  
        println("Mean Comfort = $comf, Mean NormCost = $cost\n\n")
        println("MOA in Hybrid executed for $count times, limited to 5 iterations")
        return H, [t0 t1 t2 t20 t3]

		### Plots ###
		#Te = Get_ExpectedTime(H)
		#Plot_BasicLoadArray_StackedLoads(H,Te)
		#Plot_BasicLoadArray_StackedLoads(H,t0)
		#Plot_BasicLoadArray_StackedLoads(H,t1)
		#Plot_BasicLoadArray_StackedLoads(H,t2)
		#Plot_BasicLoadArray_StackedLoads(H,t20)
		#Plot_BasicLoadArray_StackedLoads(H,t3)
		#Plot_DemandPeak(H)

		#Save_BasicLoadArray(H,"RND250") 

		### BecnhmarkTools ###
		#change default samples in BenchmakTools size to X and maxtime to X seconds
		#BenchmarkTools.DEFAULT_PARAMETERS.samples = 50
		#BenchmarkTools.DEFAULT_PARAMETERS.seconds = 2000
   	end

	"""
	H,T = RunModel()
	Plot_BasicLoadArray_StackedLoads(H, T[:x]) where x is the time output related to each simulation case
	Plot_DemandPeak(Time(0,5),4,1)
	OBS: to use BenchmarkTools functions should be run into REPL. Select it and press CTRL+ENTER
	"""
	function RunModel()
		H = Generate_Scenary1()     #Execute this 3 functions manualy to add data into REPL
		Te = Get_ExpectedTime(H)
		Tr = Get_RandomStartTime(H)

		#change default samples in BenchmakTools size to 100 and maxtime to 210 seconds
		#BenchmarkTools.DEFAULT_PARAMETERS.samples = 100
		#BenchmarkTools.DEFAULT_PARAMETERS.seconds = 300

		println("Running Model for Scenary[1] \n\n")

		########## RUN Scenary with NO Demand Restriction ##########

		println("Benchmarks for MultiObjectiveAlgorithm = Hierarchical with NO power demand constraint and StartValue at release time")
		@time t0 = JuMP_MOAVector(H)  #ALSO Execute this functions manualy to add t0 into REPL
		#b=@benchmark JuMP_MOAVector(H)
		Comf = Eval_Global_Comfort(H,t0);
		Cost = Eval_Global_Cost(H,t0);
		println("Mean Comfort = $Comf, Mean NormCost = $Cost\n\n")

		println("Benchmarks for MultiObjectiveAlgorithm = Hierarchical with NO power demand constraint and Random StartValue")
		@time t0r = JuMP_MOAVector(H; iVal=VTime2Vector(H, Tr));
		#b=@benchmark JuMP_MOAVector(H; iVal=VTime2Vector(H, Tr))
		Comf = Eval_Global_Comfort(H, t0r)
		Cost = Eval_Global_Cost(H, t0r)
		println("Mean Comfort = $Comf, Mean NormCost = $Cost\n\n")

		println("Benchmarks for MultiObjectiveAlgorithm = Hierarchical with NO power demand constraint and StartValue = Expected Time (Max Comfort)")
		@time t0e = JuMP_MOAVector(H; iVal=VTime2Vector(H, Te));
		#b=@benchmark JuMP_MOAVector(H; iVal=VTime2Vector(H, Te))
		Comf = Eval_Global_Comfort(H, t0e)
		Cost = Eval_Global_Cost(H, t0e)
		println("Mean Comfort = $Comf, Mean NormCost = $Cost\n\n")

		########## RUN Scenary with Power Demand Restriction ##########

		println("Benchmarks for MultiObjectiveAlgorithm = Hierarchical with power demand constraint and StartValue at release time")
		@time t1 = JuMP_MOAVector(H; demand=true);
		#b=@benchmark JuMP_MOAVector(H;demand=true)
		Comf = Eval_Global_Comfort(H, t1)
		Cost = Eval_Global_Cost(H, t1)
		println("Mean Comfort = $Comf, Mean NormCost = $Cost\n\n")

		println("Benchmarks for MultiObjectiveAlgorithm = Hierarchical with power demand constraint and Random StartValue")
		@time t1r = JuMP_MOAVector(H; demand=true, iVal=VTime2Vector(H, Tr));
		#b=@benchmark JuMP_MOAVector(H; demand=true, iVal=VTime2Vector(H, Tr))
		Comf = Eval_Global_Comfort(H, t1r)
		Cost = Eval_Global_Cost(H, t1r)
		println("Mean Comfort = $Comf, Mean NormCost = $Cost\n\n")

		println("Benchmarks for MultiObjectiveAlgorithm = Hierarchical with power demand constraint and StartValue = Expected Time (Max Comfort)")
		@time t1e = JuMP_MOAVector(H; demand=true, iVal=VTime2Vector(H, Te));
		#b=@benchmark JuMP_MOAVector(H; demand=true, iVal=VTime2Vector(H, Te))
		Comf = Eval_Global_Comfort(H, t1e)
		Cost = Eval_Global_Cost(H, t1e)
		println("Mean Comfort = $Comf, Mean NormCost = $Cost\n\n")

		println("Benchmarks for MultiObjectiveAlgorithm = Hierarchical with power demand constraint and StartValue = No demand Restriction")
		@time t10 = JuMP_MOAVector(H; demand=true, iVal=VTime2Vector(H, t0));
		#b=@benchmark JuMP_MOAVector(H; demand=true, iVal=VTime2Vector(H, t0))
		Comf = Eval_Global_Comfort(H, t10)
		Cost = Eval_Global_Cost(H, t10)
		println("Mean Comfort = $Comf, Mean NormCost = $Cost\n\n")

		#io = IOBuffer();                   #run this 3 lines of code to in REPL to save benchmarks into *.txt file
		#show(io, "text/plain", b);
		#write("benchmark0.txt", take!(io));

		return H, [t0 t0e t0r t1 t1e t1r t10]
	end


end # module SHC