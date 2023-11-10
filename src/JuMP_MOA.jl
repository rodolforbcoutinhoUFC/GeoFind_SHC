"""
Short functions to use within Objective Funcions Definitions
"""

Comf(L,i) = Eval_BasicLoad_Comfort(L, L.s[i])
Cost(L,i) = Eval_BasicLoad_Cost(L,L.s[i])


"""
Auxiliar function to convert binary vector to time position
"""

function find_time(A,n)
	V = Vector{Int64}(undef,n)
	for key in eachindex(A)
		if A[key] > 0.5
			V[key[1]] = key[2]
		end
	end
	return V
end

"""
Auxiliar function to convert time position to binary vector
"""
function Time2Vector(L::BasicLoad, t::Time)

    val = zeros(length(L.s))

    for i in eachindex(L.s)
        if t >= L.s[i]
            val[i] = 1
            return val
        end
    end
    @warn("Could not find time t in L,s")
end

"""
Find the best scheduling time for 1 BasicLoad
    return the scheduling time t::Time
"""
function JuMP_MOA(L::BasicLoad; demand::Bool = false, start_val = zeros(length(L.s)))

	model = Model()
	set_optimizer(model, () -> MOA.Optimizer(HiGHS.Optimizer))
	set_attribute(model, MOA.Algorithm(), MOA.Hierarchical())

	u = length(L.s)
	@variable(model, x[i=1:u], Bin, start = start_val[i])
	@constraint(model,sum(x)==1)

	if demand
		P = Generate_PowerMatrix(L)
		R = Generate_DemandPeakRef(L.Δt, 4, 1)

		for i in eachindex(R)
			if any(!iszero, P[i, :])
				@constraint(model, 0 <= P[i, :]' * x <= R[i])
			end
		end
	end

	@expression(model, Cost_expr, sum(Cost(L,i)*x[i] for i in 1:u) ) #MIN
	@expression(model, Comf_expr, sum(Comf(L,i)*x[i] for i in 1:u) ) #MAX

	@objective(model, Max, [-Cost_expr, Comf_expr])
	optimize!(model)
	#write_to_file(model, "test.mof.json")
	if termination_status(model) != OPTIMAL
		@warn("The model was not solved correctly.")
		return
	end
	solution_summary(model)

	A = value.(x)
	ix = findfirst(x -> x > 0.5 , A)
	return L.s[ix]
end

"""
Find the best scheduling time for a Vector of BasicLoads
    return the scheduling time for each Load in Vector t::Vector{Time}
"""
function JuMP_MOAVector(H::Vector{BasicLoad};demand::Bool = false, iVal = nothing, load_size = nothing, demand_scale::Float64 = 1.0 )

	model = Model()
	#set_optimizer(model, () -> MOA.Optimizer(HiGHS.Optimizer))
	set_optimizer(model, () -> MOA.Optimizer(Gurobi.Optimizer))

	#set_attribute(model, MOA.Algorithm(), MOA.Chalmet())
	#set_attribute(model, MOA.Algorithm(), MOA.EpsilonConstraint())
	set_attribute(model, MOA.Algorithm(), MOA.Hierarchical())
	#set_attribute(model, MOA.Algorithm(), MOA.KirlikSayin())
	#set_attribute(model, MOA.Algorithm(), MOA.Lexicographic())

	set_optimizer_attribute(model, "output_flag", false)
	set_optimizer_attribute(model, "time_limit", 120)

	n = length(H)
	u = Vector{Int64}(undef,n)
	for i in 1:n
		u[i] = length(H[i].s)
	end

	if iVal === nothing
		sVal = Vector{Vector{Bool}}(undef, n)
		for i in 1:n
			sVal[i] = zeros(u[i])
		end
		@variable(model, x[i=1:n, j=1:u[i]], Bin, start = sVal[i][j])
	else
		@variable(model, x[i=1:n, j=1:u[i]], Bin, start = iVal[i][j])
	end
	#@variable(model, x[i=1:n, j=1:u[i]], Bin)
	@constraint(model, c[i = 1:n], sum(x[i, :]) == 1)

	if demand
		if load_size === nothing
			m = n
		else
			m = load_size 
		end

		R = Generate_DemandPeakRef(H[1].Δt, ((4 * m * demand_scale) ÷ 10), ((1 * m) ÷ 10))
		P = Generate_PowerMatrixVector(H)

		for i in eachindex(R)
			@constraint(model, 0 <= sum(P[j][i, k]' * x[j, k] for j = 1:n, k in 1:u[j]) <= R[i])
		end

	end

	#MIN
	@expression(model, Cost_expr, sum(Cost(H[i],j)*x[i,j] for i in 1:n, j in 1:u[i]))
	#MAX
	@expression(model, Comf_expr, sum(Comf(H[i],j)*x[i,j] for i in 1:n, j in 1:u[i])) 

	@objective(model, Max, [-Cost_expr, Comf_expr])
	optimize!(model)
	if termination_status(model) != OPTIMAL
		@warn("The model was not solved correctly.")
		return
	end
	solution_summary(model)

	ix = find_time(value.(x),n)
	t = Vector{Time}(undef, n)

	for i in 1:n
		t[i] = H[i].s[ix[i]]
	end
	return t
end


"""
Hybrid methodology, use MOA after cutting scheduled loads not in demand peak after GeoFind results.
"""
function Hybrid(H::Vector{BasicLoad}; demand_scale::Float64 = 1.0, max_iterations::Int64 = 5)
	t = Best_GeoFindVector(H)
	count::Int64 = 0
	while(true)
		Hcut, B = find_demand_peaks(H, t)
		L = length(B)
		println("Hybrid found $L loads causing excessive power demand in iteration $count\n")
		if isempty(B) || (count ≥ max_iterations)
			return t, count
		end
		tcut = JuMP_MOAVector(Hcut; demand=true, load_size=length(H), demand_scale=demand_scale)

		for i in eachindex(B)
			t[B[i]] = tcut[i]
		end
		#Plot_BasicLoadArray_StackedLoads(H,t)
		count+=1
	end
end