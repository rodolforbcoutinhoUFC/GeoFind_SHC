#################################################################
#Auxiliary Functions 
#################################################################
"""
Generate time based horizontal axis with time spam of hora
"""
function time_xaxis(hora::Int64)
    
    DateTick=Time(0):Hour(hora):Time(23,59,59)
    DateTickFormat = Dates.format.(DateTick, "HH:MM")
    
    return (DateTick, DateTickFormat)
end

"""
Generate random behavior for a load
"""
function RND_Power(; max_load_power::Number = 1.0)
    P_av = rand(max_load_power/100:0.01:max_load_power)
    P_pk = P_av*rand(0.1:0.1:0.5) 
    w = rand(0.5:0.1:5)
    return P_av,P_pk,w
end 

#################################################################
#Funções Principais e estruturas de dados #######################
#################################################################
"""
Define all properties and constructors of BasicLoad
"""
struct BasicLoad
    # md" $r_i$: release time
    r::Time  
    # md" $e_i$: expected ON time      
    e::Time       
    # md" $d_i$: dead line
    d::Time          
    # md" $s_i$: start time
    s::StepRange{Time, Minute} 
    # md" $Δt$: discrete step in which a load could move through time, common to all loads in set
    Δt::Time 
    # md" $C_i$: width of the i-th load, usually measured in minutes      
    C::Time  
    # md" $C_i^Δ$: discrete load width, multiples of Δt    
    CΔ::Int64
    # md" $P_i(t)$: behavior of the i-th load through time 
    # md" OBS: typeof(P) == Array{Number,1} OR Function t -> f(t)"
    # md" OBS: length(P{Array}) = CΔ"         
    P   
    # md" $\bar{P_i}$: average power of the i-th load     
    P_av::Number  
    # md" $\hat{P_i}$: peak power of the i-th load   
    P_pk::Number     
    # md" $μ_i relevance of the i th load, ∈ [ 0, 1 ]
    μ::Number
    # md" Identify the Load By Name"
    ID::String

    BasicLoad() = new()

    function BasicLoad(r, e, d, Δt, C, P, μ, ID::String; allow_rand_peak=true)
        CΔ = div(C.instant, Δt.instant)

        s = r:Minute(Δt):(Time(d - C))
        if typeof(P) <: Function
            V = P.(1:CΔ)
        elseif typeof(P) <: Array
            if length(P) == CΔ
                V = P
            else
                @error "Unable to create new Load. P::Array{Number,1} must be compatible with Δt size"
                return nothing
            end
        else
            @error "Unable to create new Load. P must be a Function t -> f(t) or Array{Number,1} type"
            return nothing
        end

        P_av = mean(V)
        P_pk = maximum(V)

        if (P_pk == P_av) && (allow_rand_peak)
            P_pk = P_av * rand(1.1:0.1:1.5)
        end
        new(r, e, d, s, Δt, C, CΔ, P, P_av, P_pk, μ, ID)
    end

    function BasicLoad(r,e,d,Δt,C,P; allow_rand_peak = true)
        CΔ = div(C.instant,Δt.instant)
        
        s = r:Minute(Δt):(Time(d-C))
        if typeof(P) <: Function
            V = P.(1:CΔ)
        elseif typeof(P) <: Array
            if length(P) == CΔ 
                V = P
            else
                @error "Unable to create new Load. P::Array{Number,1} must be compatible with Δt size"
                return nothing
            end
        else
            @error "Unable to create new Load. P must be a Function t -> f(t) or Array{Number,1} type"
            return nothing
        end

        P_av = mean(V)
        P_pk = maximum(V)

        if (P_pk == P_av)&&(allow_rand_peak)
            P_pk = P_av*rand(1.1:0.1:1.5)
        end
        new(r,e,d,s,Δt,C,CΔ,P,P_av,P_pk,1,"L")
    end
end

##########################################
#BasicLoad and BasicLoadArray generators
##########################################

function Generate_BasicLoad(Δt::Time; max_load_power::Number = 1.0)

    while true
        TR_Day = Dates.Time(0):Dates.Minute(Δt):Dates.Time(23, 59, 59)
        TR_OFFSET = Dates.Time(0):Dates.Minute(Δt):Dates.Time(12)
        r = Time(rand(TR_Day).instant + rand(TR_OFFSET).instant)
        e = Time(rand(TR_Day).instant + rand(TR_OFFSET).instant)
        d = Time(rand(TR_Day).instant + rand(TR_OFFSET).instant)
        C = rand(Δt:Dates.Minute(Δt):Dates.Time(6))
        
        if r.instant ≤ e.instant && e.instant + C.instant ≤ d.instant
            P_av,P_pk,w = RND_Power(; max_load_power=max_load_power)
            P(t) = P_av + P_pk*sin(w*t)
            return BasicLoad(r,e,d,Δt,C,P)
        end
    end
end

function Generate_BasicLoadArray(Δt::Time, size::Int64; max_load_power::Number = 1.0)
    L = Array{BasicLoad,1}(undef, size)
    for i in eachindex(L)   
        L[i] = Generate_BasicLoad(Δt; max_load_power=max_load_power)
    end
    return L
end

#################################
#Get Fields from BasicLoadArray
#################################
"""
Get average power for each load in H
"""
function Get_Power_av(H::Array{BasicLoad,1})
    return getfield.(H, :P_av)
end
"""
Get user expected time for each load in H
"""
function Get_ExpectedTime(H::Array{BasicLoad,1})
    return getfield.(H, :e)
end
"""
Get possible random (due to eahc H.s) start times fir each load in H
"""
function Get_RandomStartTime(H::Array{BasicLoad,1})
    return map(x->rand(x), getfield.(H, :s)) 
end

###################################################
#Convert BasicLoadArray to DataFrame or BSON file
###################################################

function BasicLoadArray_To_Dataframe(H::Array{BasicLoad,1})
    return DataFrame(Dict(n=>[getfield(x,n) for x in H] for n in fieldnames(BasicLoad)))
end

function Save_BasicLoadArray(H::Array{BasicLoad,1},filename::String)
    bson(filename*".bson",Dict(:H=>H))
end

function Load_BasicLoadArray(filename::String)
    Temp = BSON.load(filename*".bson")
    return Vector{BasicLoad}(Temp[:H])
end

##############################
#PLOT FUNCTIONS FOR BASICLOAD
##############################

function Plot_BasicLoad(bl::BasicLoad, s::Time; color = :red, load_details::Bool = false, load_name::String ="")
    # md" $s_i$: _start time_
    # md" $f_i$: _finish time_

    if load_name == ""
        load_name = bl.ID
    end

    # md"L[i].r ≤ L[i].e ≤ L[i].W + L[i].d"
    f = Time(s.instant+bl.C.instant)
    if (s < bl.r) || (f > bl.d) 
        @error "s parameter is out load release and deadline range"
        return nothing
    end

    #average power of load
    t = [Time(0), s, f, Time(23,59,59)]
    p_av = [0,bl.P_av,0,0]
    
    plot(
        ylabel="kW",
        legend=:outertopright, 
        xticks=(time_xaxis(2)),
    )

    # 🐛 -> https://github.com/JuliaPlots/Plots.jl/issues/4660
    #href = [Time(16,30),Time(17,30),Time(20,30),Time(21,30)] 
    #vline!(href, line = :dot, c = :black)

    myp = plot!(t,p_av, c = color, seriestype = :steppost, label = "\$\\bar{P}\$ "*load_name)

    if load_details
        #peak power
        p_pk = [0,bl.P_pk,0,0]
        plot!(t,p_pk, line = :dot, c = color, seriestype = :steppost, label = "\$\\hat{P}\$ "*load_name)
        
        #detailed power description
        t2 = Time(0):Minute(bl.Δt):Time(23,59,59)
        l = length(t2)
        val = zeros(l)
        for i in 1:l
            if t2[i] >= s && t2[i] < Time(s.instant+bl.C.instant)
                if typeof(bl.P) <: Function
                    val[i] = bl.P(i)
                else
                    val[i] = bl.P[i-div(s.instant,bl.Δt.instant)]
                end
            end
        end
        myp = plot!(t2, val, line = :dash, c = color, label = "P "*load_name)
    end
    
    #Force plot into VSCODE
    display("image/png", myp)
end

function Plot_BasicLoad!(bl::BasicLoad, s::Time; color = :red, load_details::Bool = false, load_name::String ="")
    # md" $s_i$: _start time_
    # md" $f_i$: _finish time_

    if load_name == ""
        load_name = bl.ID
    end

    # md"L[i].r ≤ L[i].e ≤ L[i].W + L[i].d"
    f = Time(s.instant+bl.C.instant)
    if (s < bl.r) || (f > bl.d) 
        @error "s parameter is out load release and deadline range"
        return nothing
    end

    #average power of load
    t = [Time(0), s, f, Time(23,59,59)]
    p_av = [0,bl.P_av,0,0]
    
    myp = plot!(t,p_av, c = color, seriestype = :steppost, label = "\$\\bar{P}\$ "*load_name)

    if load_details
        #peak power
        p_pk = [0,bl.P_pk,0,0]
        plot!(t,p_pk, line = :dot, c = color, seriestype = :steppost, label = "\$\\hat{P}\$ "*load_name)
        
        #detailed power description
        t2 = Time(0):Minute(bl.Δt):Time(23,59,59)
        l = length(t2)
        val = zeros(l)
        for i in 1:l
            if t2[i] >= s && t2[i] < Time(s.instant+bl.C.instant)
                if typeof(bl.P) <: Function
                    val[i] = bl.P(i)
                else
                    val[i] = bl.P[i-div(s.instant,bl.Δt.instant)]
                end
            end
        end
        myp = plot!(t2, val, line = :dash, c = color, label = "P "*load_name)
    end
    
    #Force plot into VSCODE
    display("image/png", myp)
end

function Plot_BasicLoadArray(H::Array{BasicLoad,1}, pos::Array{Time,1}; load_details::Bool = false)
    
    if length(H) ≠ length(pos)
        println("cannot plot data with unequal lengths")
        return nothing
    end

    l = length(H)

    if l > 1
        color_palette = palette(:brg,l)
        Plot_BasicLoad(H[1], pos[1]; color = color_palette[1], load_details = load_details, load_name = string(1))
        for i in 2:l
            Plot_BasicLoad!(H[i], pos[i]; color = color_palette[i], load_details = load_details, load_name = string(i))
        end
    else
        Plot_BasicLoad(H[1], pos[1]; load_details = load_details)
    end
end

"""
Plot a Vector{BasicLoad} over start time into pos::Vector{Time}. It accumulate the power into certical axis
"""
function Plot_BasicLoadArray_StackedLoads(H::Array{BasicLoad,1}, pos::Array{Time,1})
    T0 = [Time(0) for x in 1:length(pos)]
    TF = [Time(23,59,59) for x in 1:length(pos)] 
    
    f = Array{Time,1}(undef, length(pos))
    for i in eachindex(f)
        f[i] = Time(pos[i].instant + H[i].C.instant)
    end

    X = [T0 pos f TF]
    Y = getfield.(H, :P_av)

    X0 = sort(unique(X))
    Y0 = zeros(length(X0),length(Y))

    for j in eachindex(Y)
            for i in eachindex(X0)
                if X0[i] ≥ X[j,2] && X0[i] < X[j,3]
                    Y0[i,j] = Y[j]
                end
            end
        end
    plot(
        ylabel="Stacked Load Power [kW]",
        #legend=false,
        #legend=:outertopright,
        legend=:bottomleft,
        xticks=(time_xaxis(2)),
    )
    load_names = permutedims(getfield.(H, :ID))
    myp = areaplot!(X0, Y0, fa=0.3, st=:steppost,
        label=load_names)
    display("image/png", myp)
end