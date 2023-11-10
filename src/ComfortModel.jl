"""
Evaluate Comfort of a BASICLOAD due to schedule Time 's'
"""
function Eval_BasicLoad_Comfort(L::BasicLoad, s::Time; op::String="frac")

    if s < L.r || s > L.d
        @error "Start instant should be between release and dead line"
        return nothing
    elseif L.e < L.r || L.e > L.d
        @error "Expected instant should be between release and dead line"
        return nothing
    end

    DMAX = max(abs(L.r - L.e), abs(L.d - L.e))
    DISC = DMAX - abs(s - L.e)

    if op == "frac"
        return DISC / DMAX
    elseif op == "num"
        return Dates.value(DISC) / 1e9
    elseif op == "den"
        return Dates.value(DMAX) / 1e9
    else
        @error "Invalid parameter op [\"frac\" \"num\" \"dem\"]"
        return nothing
    end
end

"""
Evaluate Comfort of a Vector{BASICLOAD} due to schedule Vector{Time} 'T'
"""
function Eval_ComfortVector(L::BasicLoad)
	l = length(L.s)
	Comf = Vector{Float64}(undef,l)
	for i in 1:l
		Comf[i] = Eval_BasicLoad_Comfort(L, L.s[i])
	end
	return Comf
end

"""
Evaluate Comfort of a Vector{BASICLOAD} due to schedule Vector{Time} 'T'
"""
function Eval_Global_Comfort(H::Vector{BasicLoad}, T::Vector{Time})
    comf = Vector{Float64}(undef, length(T))
    for i in eachindex(T)
        comf[i] = Eval_BasicLoad_Comfort(H[i], T[i])
    end
    return sum(comf) / length(T)
end