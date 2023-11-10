#################################################################
#Function and structures related to energy analysis
#################################################################
struct __tarifa
    tc::Float64     # md" $t_c$: constant tariff"
    tf::Float64     # md" $t_f$: off peak post tariff"
    ti::Float64     # md" $t_i$: intermediate post tariff"
    tp::Float64     # md" $t_p$: peak post tariff"
end

tarifa = __tarifa(0.58878,0.48771,0.80221,1.26812)
const tarifa_comum::Float64 = 0.58878
const tarifa_branca = Vector{Float64}([0.48771, 0.80221, 1.26812])

"""
Generate a vector over time that has cost values of Brazillian energy tariff
"""
function GeradorVetorTarifasBaixaTensão(Δt::Time;TB::Vector{Float64} = tarifa_branca, TC::Float64 = tarifa_comum, OP::String = "Branca")
	
	t = Time(0):Minute(Δt):Time(23,59,59)
	l = length(t)
	val_B = Vector{Float64}(undef,l)
	val_C = ones(l)*TC

	for i in 1:l
		if t[i] < Time(16,30)
			val_B[i] = TB[1]
		elseif t[i] >= Time(16,30) && t[i] < Time(17,30)
			val_B[i] = TB[2]
		elseif t[i] >= Time(17,30) && t[i] < Time(20,30)
			val_B[i] = TB[3]
		elseif t[i] >= Time(20,30) && t[i] < Time(21,30)
			val_B[i] = TB[2]
		else
			val_B[i] = TB[1]
		end
	end	

	if OP == "Branca"
		return val_B
	elseif OP == "Comum"
		return val_C
	else
		@error "Invalid parameter OP=[\"Branca\" \"Comum\"]"
		return nothing
	end
end

"""
Generate Restriction Deman (Max Power Demand allowed) per discret time unit Δt.
D is the Max value
Npk is the negative peak value of the gaussian curve that simulates 
    non schedulable loads in peak tariff hours
"""
function Generate_DemandPeakRef(Δt::Time, D, Npk)

    t = Time(0):Minute(Δt):Time(23, 55, 55)
    l = length(t)
    val = Vector{Float64}(undef, l)

    for i in 1:l
        if t[i] < Time(16, 30)
            val[i] = D
        elseif t[i] >= Time(16, 30) && t[i] < Time(21, 30)
            val[i] = D - Npk * exp(-(i - 230)^2 / 170)
        else
            val[i] = D
        end
    end
    #plot(val)
    return val
end

"""
!plot the demand constrait over time. Use it into/after load plot
"""
function Plot_DemandPeak(Δt::Time, D, Npk)
    t = Time(0):Minute(Δt):Time(23, 55, 55)
    v = Generate_DemandPeakRef(Δt::Time, D, Npk)
    myp = plot!(t, v, xticks=(time_xaxis(2)))
    display("image/png", myp)
end

"""
Generate the PowerMatrix of a Load over time for each position possible in L.s
"""
function Generate_PowerMatrix(L::BasicLoad)

    t = Time(0):Minute(L.Δt):Time(23, 55, 55)
    l = length(t)
    u = length(L.s)
    val2 = zeros(l, u)

    for j in 1:u
        for i in 1:l
            if t[i] ≥ L.s[j] && t[i] < Time(L.s[j].instant + L.C.instant)
                val2[i, j] = L.P_av
            end
        end
    end

    return val2
end

"""
Generate a Vector of PowerMatrix for each Load into H
"""
function Generate_PowerMatrixVector(H::Vector{BasicLoad})

    v = Vector{Matrix{Float64}}(undef, length(H))

    for i in eachindex(H)
        v[i] = Generate_PowerMatrix(H[i])
    end

    return v
end

"""
Evaluate Cost of a Vector{BASICLOAD} related to schedule Time 's'
"""
function Eval_BasicLoad_Cost(L::BasicLoad, s::Time; TB::Vector{Float64}=tarifa_branca, TC::Float64=tarifa_comum, OP::String="Norm")
    P = Decompose_Time(L, s)
    En = [P[1], P[2], P[3]]
    k = Time(1).instant / L.Δt.instant

    CustoBranca = k * L.P_av * (TB' * En)
    CustoComum = k * L.CΔ * L.P_av * TC
    CustoMinimo = k * L.CΔ * L.P_av * TB[1]

    if OP == "Norm"
        return (CustoBranca) / CustoComum
    elseif OP == "Branca"
        return CustoBranca
    elseif OP == "Comum"
        return CustoComum
    elseif OP == "Min"
        return CustoMinimo
    else
        @error "Invalid parameter OP=[\"Norm\" \"Branca\" \"Comum\" \"Min\"]"
        return nothing
    end
end

function Eval_BasicLoadCost_OLD(L::BasicLoad, s::Time; TB::Vector{Float64} = tarifa_branca, TC::Float64 = tarifa_comum, OP::String = "Norm")
	#Array definitions and time constants
	t = Time(0):Minute(L.Δt):Time(23,59,59)
	f = Time(s.instant+L.C.instant)
	l = length(t)
	val = zeros(l)
	k = Time(1).instant/L.Δt.instant

	#Gera vetor com os valores da tarifa branca no tempo
	Tarifa = GeradorVetorTarifasBaixaTensão(L.Δt)

	#Valores Constantes de Custo
	CustoComum  = k*L.CΔ*L.P_av*TC
	CustoMinimo = k*L.CΔ*L.P_av*TB[1] 

	#LOAD BEHAVIOR
	for i in 1:l
		if t[i] ≥ s && t[i] < f
			val[i] = k*L.P_av*Tarifa[i]
		end
	end

	if OP == "Norm"
		return sum(val)/CustoComum
	elseif OP == "Branca"
		return sum(val)
	elseif OP == "Comum"
		return CustoComum
	elseif OP == "Min"
		return CustoMinimo
	else
		@error "Invalid parameter OP=[\"Norm\" \"Branca\" \"Comum\" \"Min\"]"
		return nothing
	end
end

Cost(L, i) = Eval_BasicLoad_Cost(L, L.s[i]) #use it in MOA functions for short

"""
Evaluate Cost of a Vector{BASICLOAD} related to schedule Vector{Time} 'T'
"""
function Eval_Global_Cost(H::Vector{BasicLoad}, T::Vector{Time})
    cost = Vector{Float64}(undef, length(T))
    for i in eachindex(T)
        cost[i] = Eval_BasicLoad_Cost(H[i], T[i])
    end
    return sum(cost) / length(T)
end