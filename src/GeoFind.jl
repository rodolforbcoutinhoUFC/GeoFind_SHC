"""
Decompose time into tariff space (^f, ^i, ^p)
"""
function Decompose_Time(Δt::Time, s::Time, C::Time)
    # define _finish time_
    f = Time(s.instant + C.instant)

    # time to its discreet values
    sΔ = div(s.instant,Δt.instant)
    fΔ = div(f.instant,Δt.instant)
    CΔ = div(C.instant,Δt.instant)

    # define white tariff posts
    Ti_s = Time(16,30)
    Ti_sΔ = div(Ti_s.instant,Δt.instant)
    Tp_s = Time(17,30)
    Tp_sΔ = div(Tp_s.instant,Δt.instant)
    Tp_f = Time(20,30)
    Tp_fΔ = div(Tp_f.instant,Δt.instant)
    Ti_f = Time(21,30)
    Ti_fΔ = div(Ti_f.instant,Δt.instant)

    #vf = off peak vector component
    vf::Float64 = 0
    if s ≥ Ti_f || f ≤ Ti_s
        vf = CΔ
    end
    if s < Ti_s && f > Ti_s 
        vf += Ti_sΔ - sΔ
    end
    if s < Ti_f && f > Ti_f
        vf += fΔ - Ti_fΔ
    end

    #vp = peak vector component
    vp::Float64 = 0
    if s ≥ Tp_s && f ≤ Tp_f
        vp = CΔ
    elseif s ≤ Tp_s && f ≥ Tp_s
        vp = min(fΔ,Tp_fΔ) - Tp_sΔ
    elseif s ≤ Tp_f && f ≥ Tp_f
        vp = Tp_fΔ - max(sΔ,Tp_sΔ)
    end
    #vi = intermediate vector component
    vi::Float64 = 0
    if (s ≥ Ti_s && f ≤ Tp_s) || (s ≥ Tp_f && f ≤ Ti_f)
        vi = CΔ
    else
        if s ≤ Ti_s && f ≥ Ti_s
            vi += min(fΔ,Tp_sΔ) - Ti_sΔ
        elseif s ≤ Tp_s && f ≥ Tp_s
            vi += Tp_sΔ - max(sΔ,Ti_sΔ)
        end

        if s ≤ Tp_f && f ≥ Tp_f
            vi += min(fΔ,Ti_fΔ) - Tp_fΔ
        elseif s ≤ Ti_f && f ≥ Ti_f
            vi += Ti_fΔ - max(sΔ,Tp_fΔ)
        end
    end
    return Point(vf,vi,vp)
end

function Decompose_Time(L::BasicLoad, s::Time)
    return Decompose_Time(L.Δt, s, L.C)
end

"""
Recompose time based on a point into tariff space
"""
function Recompose_Time(L::BasicLoad, P::Point3{Float64})
    Δt = L.Δt
    e = L.e
    
    Ti_s = Time(16,30)
    Ti_f = Time(21,30)

    k = Time(1).instant / Δt.instant

    if abs(Ti_s - e) ≤ abs(Ti_f - e)
        d1 = P[1]/k
        h1 = Int(floor(div(d1,1)))
        m1 = Int(floor(mod(d1,1)*60))
        return Time(Ti_s.instant - Time(h1,m1).instant)
    else
        d2 = (P[2]/k) + (P[3]/k)
        h2 = Int(floor(div(d2,1)))
        m2 = Int(floor(mod(d2,1)*60))
        return Time(Ti_f.instant - Time(h2,m2).instant)
    end
end

"""
Find interssection point between load geometry locus and its lower cost region
"""
function GeoFind(L::BasicLoad; tc = tarifa.tc, tp = tarifa.tp, ti = tarifa.ti, tf = tarifa.tf)
    D = L.CΔ
    Δt = L.Δt
    
    if (D ≤ 1)
        return Point(D,0.0,0.0)
    end
    # md" Define discrete quantity 1H related to Δt"
    k = Time(1).instant / Δt.instant

    # md" Load point (feasible) in which it has only intermediate and off peak post components"
    bi = floor(D*(tc - tf)/(ti - tf))
    bf = D - bi
    #pB = Point(bf, bi, 0.0)
    
    # md" Fist bes point"
    Pbest1 = Point((bf), (bi),0.0)
    
    if (D ≤ k)
        return Pbest1
    end

    # md" Load point (not feasible) in which it has only peak and off peak post components"
    ap = floor(D*(tc - tf)/(tp - tf))
    #af = D - ap
    #pA = Point(af, 0.0, ap)
    
    p_b2 = (ap-(k*(ap/bi)))
    p_b2r = floor(p_b2)
    f_b2 = D - k - p_b2r #(af+(k*((bf-af)/bi)))
    Pbest2 = Point(f_b2, k, p_b2r)

    #return (Pbest1,Pbest2) #Debug
    return p_b2 ≥ 0.0 ? Pbest2 : Pbest1
end

"""
Full load analysis over TimeSpace Decomposition, including defective load case
"""
function Best_GeoFind(L::BasicLoad)
	Pe = Decompose_Time(L, L.e)
	if Pe[1] == L.CΔ
		return L.e
	end

	A = GeoFind(L)
	t = Recompose_Time(L, A)

	if (L.s[1] ≤ t) && (t ≤ L.s[end])
		return t
	end

	C1   = Eval_BasicLoad_Comfort(L, L.s[1])/Eval_BasicLoad_Cost(L, L.s[1])
	Ce   = Eval_BasicLoad_Comfort(L, L.e)/Eval_BasicLoad_Cost(L, L.e)
	Cend = Eval_BasicLoad_Comfort(L, L.s[1])/Eval_BasicLoad_Cost(L, L.s[end])

	#return C1 ≥ Cend ? L.s[1] : L.s[end]

	val,tempo = C1 ≥ Cend ? (C1,L.s[1]) : (Cend,L.s[end])
	return Ce ≥ val ? L.e : tempo
end

"""
Find all best scheduling times based on Best_Geofind for a vector of Loads
"""
function Best_GeoFindVector(H::Vector{BasicLoad})
	t = Vector{Time}(undef, length(H))

	for i in eachindex(H)
		t[i] = Best_GeoFind(H[i]) 
	end
	return(t)
end

"""
Plot Funciton that generate the 3D Time Space Decomposition illustration for a load and its geometric locus
"""
function Generate_BasicLoad_TimeSpace(D::Int64, Δt::Time, Pe::Point, Vp::Vector{Point{3, Float32}}, Cost::Vector{Float64}; tc = tarifa.tc, tp = tarifa.tp, ti = tarifa.ti, tf = tarifa.tf)
    
    # md" Load is 100% in off peak post "
    P0 = Point(D,0.0,0.0)

    # md" Load point (not feasible) in which it has only peak and off peak post components"
    ap = D*(tc - tf)/(tp - tf)
    af = D - ap
    pA = Point(af, 0.0, ap)

    # md" Load point (feasible) in which it has only intermediate and off peak post components"
    bi = D*(tc - tf)/(ti - tf)
    bf = D - bi
    pB = Point(bf, bi, 0.0)

    # md" Evaluate the possible interssection points"
    Pbest1 = Point(ceil(bf), floor(bi),0)
    k = Time(1).instant / Δt.instant
    Pbest2 = Point(ceil(af+(k*((bf-af)/bi))), k, floor(ap-(k*(ap/bi))))

    f = Figure(backgroundcolor = RGBf(0.98, 0.98, 0.98), fontsize = 16)
    Axis3(f[1,1],
        title = "Geometric Time Space - Residential White Tariff",
        xlabel = L"\hat{f}",
        ylabel = L"\hat{i}",
        zlabel = L"\hat{p}",
        aspect = :data,
        viewmode = :fit,
        azimuth = pi/4)

	#Generate 3D triangle that represent plane of possible load movimentation over tariff posts into decomposed time
    T = Polygon([Point(D,0.0,0.0), Point(0.0,D,0.0), Point(0.0,0.0,D)])
    mesh_T = decompose(Point,T)
    lines!(T, color = :gray)
    mesh!(mesh_T, color = (:gray, 0.2), transparency = true)
    
    #Generate triangle that illustrates lower cost region
    tri = Polygon([P0,pA,pB])
    mesh_tri = decompose(Point,tri)
    lines!(tri, color = :red)
    mesh!(mesh_tri, color = (:red, 0.2), transparency = true)

    #Generate geometric locus
    color = Reverse(:imola)
    GLMakie.scatter!(Vp; color=Cost, colormap=color, markersize=10)

    #mark fist best point i = D - f ≤ k; p = 0
    #GLMakie.scatter!(Pbest1; color = :purple)

    #mark second best point  i = k, f = (D-k) - p
    #scatter!(Pbest2; color = :pink)

    #mark expected scheduling point
    #GLMakie.scatter!(Pe; color = :orange)
    #text!(Pe, text = "MaxComfort", color = :orange, offset = (0, -20), align = (:left, :bottom))
    Colorbar(f[1,2],
                label = "Normalized Cost",
                limits = (minimum(Cost), maximum(Cost)),
                colormap = color)

    display(f)
    return f
end