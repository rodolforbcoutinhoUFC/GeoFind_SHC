"""
Generate a house with 11 schedulabe appliances
    retunr a Vector{BasicLoad}
"""

function Generate_Scenary1()

    Δt = Time(0,5)

    L = Array{BasicLoad,1}(undef, 11)

#LOAD1
    ID = "Water tank pump"
    r = Time(7)
    e = Time(8)
    d = Time(17)
    C = Time(0,20)
    P_av = 2.0
    P_pk = 1.0
    w = rand(1:0.1:5)
    P1(t) = P_av + P_pk*sin(w*t)
    μ = 0.1
    L[1] = BasicLoad(r,e,d,Δt,C,P1,μ,ID; allow_rand_peak = false)

#LOAD2
    ID = "Pool Filter Pump"
    r = Time(7)
    e = Time(8)
    d = Time(17)
    C = Time(2)
    P_av = 0.75
    P_pk = 0.75
    w = rand(1:0.1:5)
    P2(t) = P_av + P_pk*sin(w*t)
    μ = 0.1
    L[2] = BasicLoad(r,e,d,Δt,C,P2,μ,ID; allow_rand_peak = false)

#LOAD3
    ID = "Iron"
    r = Time(14)
    e = Time(15)
    d = Time(17)
    C = Time(2)
    P_av = 1.0
    P_pk = 0.2
    w = rand(1:0.1:5)
    P3(t) = P_av + P_pk*sin(w*t)
    μ = 0.3
    L[3] = BasicLoad(r,e,d,Δt,C,P3,μ,ID; allow_rand_peak = false)

#LOAD4
    ID = "Waching Machine"
    r = Time(7)
    e = Time(8)
    d = Time(17)
    C = Time(1)
    
    V4 = [0.13 0.70 0.51 0.51 0.30 0.26 0.26 0.15 0.15 0.15 0.22 0.30]
    μ = 0.5
    L[4] = BasicLoad(r,e,d,Δt,C,V4,μ,ID; allow_rand_peak = false)

#LOAD5
    ID = "External Lamps"
    r = Time(17)
    e = Time(18)
    d = Time(23,59,59)
    C = Time(4,30)
    P5 = t->0.3
    μ = 0.3
    L[5] = BasicLoad(r,e,d,Δt,C,P5,μ,ID; allow_rand_peak = false)

#LOAD6
    ID = "Indoor Lamps"
    r = Time(17)
    e = Time(18)
    d = Time(23,59,59)
    C = Time(4,30)
    P6 = t->0.15
    μ = 0.7
    L[6] = BasicLoad(r,e,d,Δt,C,P6,μ,ID; allow_rand_peak = false)

#LOAD7
    ID = "AirConditioning1"
    r = Time(17)
    e = Time(20)
    d = Time(23,59,59)
    C = Time(1,15)
    V7 = [1.70 1.30 1.30 1.30 1.30 1.30 1.30 1.30 1.30 1.30 1.30 1.30 1.30 1.30 1.30]
    μ = 1
    L[7] = BasicLoad(r,e,d,Δt,C,V7,μ,ID; allow_rand_peak = false)

#LOAD8
    ID = "AirConditioning2"
    r = Time(17)
    e = Time(20)
    d = Time(23,59,59)
    C = Time(1,15)
    V8 = [x = rand(Bool) ? 2.0 : 2.1 for x in 1:15]
    μ = 1
    L[8] = BasicLoad(r,e,d,Δt,C,V8,μ,ID; allow_rand_peak = false)

#LOAD9
    ID = "AirConditioning3"
    r = Time(17)
    e = Time(19,50)
    d = Time(23,59,59)
    C = Time(4)
    V9 = [x = rand(Bool) ? 1.1 : 1.2 for x in 1:48]
    μ = 1
    L[9] = BasicLoad(r,e,d,Δt,C,V9,μ,ID; allow_rand_peak = false)

#LOAD10
    ID = "AirConditioning4"
    r = Time(17)
    e = Time(20)
    d = Time(23,59,59)
    C = Time(0,45)
    VA = [x = rand(Bool) ? 0.9 : 1.1 for x in 1:9]
    μ = 1
    L[10] = BasicLoad(r,e,d,Δt,C,VA,μ,ID; allow_rand_peak = false)

#LOAD11
    ID = "Dishwasher"
    r = Time(18)
    e = Time(21)
    d = Time(22)
    C = Time(0,45)
    VB = [0.033 1.76 1.76 0.33 0.33 0.33 1.76 0.33 0.33]
    μ = 1
    L[11] = BasicLoad(r,e,d,Δt,C,VB,μ,ID; allow_rand_peak = false)

    return L
end