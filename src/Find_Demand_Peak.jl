"""
Function that receive a BasicLoad Vector and a Feasible Time Scheduling Solution as parameters
Search the loads whose acculumate power generate a peak over the max power demand 
"""
function find_demand_peaks(H::Vector{BasicLoad}, pos::Vector{Time})
    #Array definitions and time constants
    n = length(H)
    R = Generate_DemandPeakRef(H[1].Δt, ((4 * n) ÷ 10), ((1 * n) ÷ 10))
    t = Time(0):Minute(H[1].Δt):Time(23,59,59)
    l = length(t)

    Y0 = zeros(l,n)
    
    for j in 1:n
        for i in 1:l
            if t[i] ≥ pos[j] && t[i] < Time(pos[j].instant + H[j].C.instant)
                #=if typeof(H[j].P) <: Function
                    Y0[i,j] = H[j].P(i)
                else
                    Y0[i,j] = H[j].P[i-div(pos[j].instant,H[j].Δt.instant)]
                end=#
                Y0[i,j] = H[j].P_av
            end
        end
    end
    
    S = sum(Y0, dims = 2)
    
    ix = findall(S .≥ R)
    
    A = Vector{Vector{Int64}}(undef,length(ix))
    
    for i in eachindex(ix)
        A[i]=findall(x -> x > 0, Y0[ix[i][1],:])
    end
    
    B = unique(Iterators.flatten(A))

    Hcut = Vector{BasicLoad}(undef,length(B))
    for i in eachindex(B)
        Hcut[i] = H[B[i]]
    end

    return Hcut, B
end
