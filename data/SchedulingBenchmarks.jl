# 10 random LOADS

GEOFINDER – B[1]
Mean Comfort = 0.976386362928405, Mean NormCost = 0.8714381522761603

BenchmarkTools.Trial: 100 samples with 9 evaluations.
 Range (min … max):  2.433 μs … 11.889 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     2.511 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   3.005 μs ±  1.187 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  █▃          ▂▂
  ██▁▄▄▁▁▁▄▄▁▁██▁▄▄▄▁▁▄▁▁▁▁▁▁▁▁▁▆▁▁▁▁▁▄▁▁▁▁▁▄▁▁▁▁▁▁▁▁▁▁▁▁▁▁▄ ▄
  2.43 μs      Histogram: log(frequency) by time        7 μs <

 Memory estimate: 1.17 KiB, allocs estimate: 40.

MOA NO DEMAND - B[2]
Mean Comfort = 0.9749415934038286, Mean NormCost = 0.8283399571996333

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  17.325 ms … 66.797 ms  ┊ GC (min … max): 0.00% … 63.51%
 Time  (median):     20.823 ms              ┊ GC (median):    0.00%
 Time  (mean ± σ):   21.857 ms ±  6.373 ms  ┊ GC (mean ± σ):  3.71% ±  8.84%

     ▅█▃▁
  ▅▃▆████▆▁▃▃▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃ ▃
  17.3 ms         Histogram: frequency by time        62.1 ms <

 Memory estimate: 5.84 MiB, allocs estimate: 111352.

MOA WITH DEMAND NO INITIALIZATION - B[3]
Mean Comfort = 0.8874726559393806, Mean NormCost = 0.8432466187473191

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  1.195 s …   1.753 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     1.228 s              ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.249 s ± 81.524 ms  ┊ GC (mean ± σ):  0.35% ± 0.85%

   ▃█▆█   
  ▆█████▄▅▃▄▃▄▃▁▃▃▃▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃ ▃
  1.2 s          Histogram: frequency by time        1.66 s <

 Memory estimate: 37.84 MiB, allocs estimate: 858383.

MOA WITH DEMAND INITIALIZED WITH GEOFINDER - B[4]
Mean Comfort = 0.8874726559393806, Mean NormCost = 0.8432466187473191

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  1.038 s …   1.267 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     1.055 s              ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.066 s ± 31.774 ms  ┊ GC (mean ± σ):  0.41% ± 0.97%

     ▃▃█▃▅ ▄   
  ▃▅▅█████▇█▆▅▅▄▁▁▃▁▁▃▃▅▄▃▁▃▃▃▃▁▁▁▁▁▄▁▁▁▁▁▁▃▁▁▃▃▁▁▁▁▁▁▁▁▁▁▃ ▃
  1.04 s         Histogram: frequency by time        1.17 s <

 Memory estimate: 37.87 MiB, allocs estimate: 859654.

HYBRID - B[5]
Mean Comfort = 0.8874726559393806, Mean NormCost = 0.8432466187473191
MOA in Hybrid executed for 1 times with 9 loads, limited to 5 iterations

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  1.152 s …   1.639 s  ┊ GC (min … max): 0.00% … 2.23%
 Time  (median):     1.187 s              ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.208 s ± 73.616 ms  ┊ GC (mean ± σ):  0.36% ± 0.89%

    ▇▆█▅  
  ▅▆████▄▁▄▄▁▄▄▄▄▁▄▁▁▃▁▁▃▁▁▁▃▁▁▃▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃ ▃
  1.15 s         Histogram: frequency by time        1.58 s <

 Memory estimate: 36.53 MiB, allocs estimate: 810913.


# 50 random LOADS

GEOFINDER – B[6]
Mean Comfort = 0.9424540465743902, Mean NormCost = 0.859369331571671

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  12.400 μs … 66.200 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     17.500 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   20.748 μs ±  8.883 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▂     █▂
  █▁▁▄▁▁██▄▁▁▁▄▁▁▄▆▆█▆▄▄▄▆▁▄▁▁▁▆▁▁▁▄▁▁▁▁▁▁▁▄▁▁▁▁▁▁▁▁▁▁▁▄▁▁▁▁▄ ▄
  12.4 μs      Histogram: log(frequency) by time      57.1 μs <

 Memory estimate: 5.45 KiB, allocs estimate: 199.

MOA NO DEMAND - B[7]
Mean Comfort = 0.9422429981279123, Mean NormCost = 0.8332566146021511

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):   85.064 ms … 192.506 ms  ┊ GC (min … max): 0.00% … 29.27%
 Time  (median):      99.148 ms               ┊ GC (median):    0.00%
 Time  (mean ± σ):   105.358 ms ±  20.351 ms  ┊ GC (mean ± σ):  6.74% ± 11.55%

      ▄ █     ▇ ▄    
  ▆▃▃▅███▆▃▅▇▇█▆█▆█▅▃▃▅▅▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁▁▃▁▅▁▁▁▅▁▃▃▃▆▁▁▁▁▅▃▅ ▃
  85.1 ms          Histogram: frequency by time          153 ms <

 Memory estimate: 40.51 MiB, allocs estimate: 805825.

MOA WITH DEMAND NO INITIALIZATION - B[8]
Mean Comfort = 0.941484632300033, Mean NormCost = 0.8394151118337146

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  2.274 s …   2.860 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     2.354 s              ┊ GC (median):    1.42%
 Time  (mean ± σ):   2.370 s ± 79.184 ms  ┊ GC (mean ± σ):  0.99% ± 0.71%

      ▂ ▂▇ █▃ ▇▃
  ▅▁▁▇███████▇██▆▇▃▆█▅▃▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▃ ▃
  2.27 s         Histogram: frequency by time        2.73 s <

 Memory estimate: 180.14 MiB, allocs estimate: 4505808.

MOA WITH DEMAND INITIALIZED WITH GEOFINDER - B[9]
Mean Comfort = 0.941484632300033, Mean NormCost = 0.8394151118337146

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  2.274 s …   2.595 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     2.340 s              ┊ GC (median):    1.49%
 Time  (mean ± σ):   2.343 s ± 49.459 ms  ┊ GC (mean ± σ):  1.01% ± 0.73%

  ▃    ▄  ▁  ▃▆▄▄██▁ ▃
  █▄▆▆▆█▇▇█▆▄███████▆█▇▇▆▆▁▆▁▆▁▁▁▁▁▁▁▁▁▁▁▁▁▄▁▁▁▁▁▁▁▁▁▁▄▁▁▁▄ ▄
  2.27 s         Histogram: frequency by time        2.54 s <

 Memory estimate: 180.07 MiB, allocs estimate: 4505707.

HYBRID - B[10]
Mean Comfort = 0.9355471323000331, Mean NormCost = 0.8394151118337146
MOA in Hybrid executed for 1 times with 22 loads, limited to 5 iterations

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  919.000 ms …   1.075 s  ┊ GC (min … max): 0.00% … 3.54%
 Time  (median):     955.835 ms              ┊ GC (median):    0.00%
 Time  (mean ± σ):   965.704 ms ± 32.149 ms  ┊ GC (mean ± σ):  0.96% ± 1.42%

       ▄ █ ▄▃▃  ▁   ▃    ▄  ▁▃
  ▆▁▆▆▆█▄█▆███▇▇█▄▄▆█▄▄▁▄█▆▆██▇▁▄▄▇▁▄▄▄▁▁▁▄▁▁▄▄▁▁▄▁▄▁▁▁▁▁▁▁▁▁▄ ▄
  919 ms          Histogram: frequency by time          1.07 s <

 Memory estimate: 82.99 MiB, allocs estimate: 1944734.

# 100 random LOADS

GEOFINDER – B[11]
Mean Comfort = 0.9415650261786803, Mean NormCost = 0.910174210245961

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  32.000 μs … 68.300 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     32.950 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   35.647 μs ±  6.777 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▁█      
  ███▄▁▁▁▁▃▁▁▁▁▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▂▁▄▂▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▂ ▂
  32 μs           Histogram: frequency by time        61.7 μs <

 Memory estimate: 15.59 KiB, allocs estimate: 598.

MOA NO DEMAND - B[12]
Mean Comfort = 0.935025223525277, Mean NormCost = 0.8635966532303432

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  206.271 ms … 344.406 ms  ┊ GC (min … max): 0.00% … 13.60%
 Time  (median):     247.769 ms               ┊ GC (median):    0.00%
 Time  (mean ± σ):   252.238 ms ±  32.443 ms  ┊ GC (mean ± σ):  8.60% ±  8.65%

      █  ▆                                 ▂             ▂       
  ▄▆▁▆██▆███▆▁▄▄▆▁██▆█▁▆▁▄▄▆▄▄█▄█▁▄▁▁▁▁▆▄▄▁█▄▆▆█▄█▆▄▆▁▁▆▄█▁▁▄▄█ ▄
  206 ms           Histogram: frequency by time          308 ms <

 Memory estimate: 123.39 MiB, allocs estimate: 2347730.

MOA WITH DEMAND NO INITIALIZATION - B[13]
Mean Comfort = 0.934350172260752, Mean NormCost = 0.8635966532303432

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  5.777 s …    7.111 s  ┊ GC (min … max): 0.54% … 0.56%
 Time  (median):     5.976 s               ┊ GC (median):    0.79%
 Time  (mean ± σ):   6.055 s ± 241.260 ms  ┊ GC (mean ± σ):  1.10% ± 0.53%

     ▂▆▂▃▃▂ █▅       ▃       ▂
  ▄▁▄█████████▅▅▅█▇▁▄██▄▁▁▁▄▁█▅▅▁▁▁▁▄▁▁▁▁▁▁▁▁▁▁▄▄▁▁▄▁▁▁▁▄▁▁▅ ▄
  5.78 s         Histogram: frequency by time         6.82 s <

 Memory estimate: 421.92 MiB, allocs estimate: 10058408.

MOA WITH DEMAND INITIALIZED WITH GEOFINDER - B[14]
Mean Comfort = 0.934350172260752, Mean NormCost = 0.8635966532303432

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  5.781 s …    6.777 s  ┊ GC (min … max): 0.68% … 1.92%
 Time  (median):     5.937 s               ┊ GC (median):    0.78%
 Time  (mean ± σ):   5.968 s ± 167.129 ms  ┊ GC (mean ± σ):  1.09% ± 0.48%

      ▂▅▃  ▅ █    ▂ ▂
  ▇██▇███▇▇█▁█▇██████▇▅▅▄▄▄▁▁▁▁▁▁▁▁▁▁▁▁▄▅▁▁▁▁▁▁▁▁▁▁▄▁▁▁▁▁▁▁▅ ▄
  5.78 s         Histogram: frequency by time         6.57 s <

 Memory estimate: 421.79 MiB, allocs estimate: 10058257.

HYBRID - B[15]
Mean Comfort = 0.9452532449688483, Mean NormCost = 0.9072415400919384
MOA in Hybrid executed for 1 times with 41 loads, limited to 5 iterations

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  1.871 s …    3.101 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     1.956 s               ┊ GC (median):    1.75%
 Time  (mean ± σ):   1.975 s ± 149.731 ms  ┊ GC (mean ± σ):  1.08% ± 0.96%

   ▂█  ▂▃▆ 
  ▆██▅▄███▇▅▆▁▄▄▁▁▃▁▁▁▁▁▃▁▃▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃ ▃
  1.87 s         Histogram: frequency by time         2.64 s <

 Memory estimate: 161.99 MiB, allocs estimate: 3552429.

# 500 random LOADS

GEOFINDER – B[16]
Mean Comfort = 0.9477226036278417, Mean NormCost = 0.8976236764940347

BenchmarkTools.Trial: 25 samples with 1 evaluation.
 Range (min … max):  147.600 μs … 374.300 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     155.000 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   173.276 μs ±  52.319 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  █▃▁
  ███▆▄▁▄▁▁▄▁▁▁▁▁▁▁▁▁▁▁▁▁▁▄▁▁▁▁▁▁▁▁▁▁▁▁▄▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▄ ▁
  148 μs           Histogram: frequency by time          374 μs <

 Memory estimate: 68.56 KiB, allocs estimate: 2632.

MOA NO DEMAND - B[17]
Mean Comfort = 0.9340477659599157, Mean NormCost = 0.854916245697625

BenchmarkTools.Trial: 25 samples with 1 evaluation.
 Range (min … max):  3.073 s …    4.562 s  ┊ GC (min … max): 13.39% … 36.05%
 Time  (median):     3.368 s               ┊ GC (median):    15.09%
 Time  (mean ± σ):   3.509 s ± 422.020 ms  ┊ GC (mean ± σ):  18.76% ±  7.37%

  ▃    ▃█▃          
  █▁▁▁▇███▇▇▁▇▁▇▇▇▇▇▁▁▁▇▁▁▁▇▇▁▇▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▇▁▁▇▁▇ ▁
  3.07 s         Histogram: frequency by time         4.56 s <

 Memory estimate: 1.72 GiB, allocs estimate: 37102644.

MOA WITH DEMAND NO INITIALIZATION - B[18]
Mean Comfort = 0.9374017478498075, Mean NormCost = 0.8589854911857181

BenchmarkTools.Trial: 25 samples with 1 evaluation.
 Range (min … max):  36.424 s …   38.919 s  ┊ GC (min … max): 1.93% … 4.04%
 Time  (median):     37.140 s               ┊ GC (median):    2.14%
 Time  (mean ± σ):   37.316 s ± 720.675 ms  ┊ GC (mean ± σ):  2.90% ± 1.04%

    █    █      ▃                   █
  ▇▇█▁▇▁▁█▁▁▁▁▇▁█▁▇▁▁▁▁▁▇▇▁▁▇▇▁▁▁▁▁▁█▇▁▁▇▁▁▁▁▇▁▁▁▁▁▁▁▁▁▁▇▁▁▁▇ ▁
  36.4 s          Histogram: frequency by time         38.9 s <

 Memory estimate: 3.13 GiB, allocs estimate: 74251275.

MOA WITH DEMAND INITIALIZED WITH GEOFINDER - B[19]
Mean Comfort = 0.9374017478498075, Mean NormCost = 0.8589854911857181

BenchmarkTools.Trial: 25 samples with 1 evaluation.
 Range (min … max):  36.535 s …   38.210 s  ┊ GC (min … max): 2.00% … 2.09%
 Time  (median):     37.307 s               ┊ GC (median):    2.27%
 Time  (mean ± σ):   37.328 s ± 427.619 ms  ┊ GC (mean ± σ):  2.88% ± 0.90%

                 █         ▃      █
  ▇▁▁▁▁▁▁▁▇▁▁▇▁▁▇█▁▁▇▇▁▇▁▁▁█▁▇▇▇▇▁█▁▁▇▁▁▁▁▁▁▁▁▇▇▁▁▁▁▁▁▇▁▁▁▁▇▇ ▁
  36.5 s          Histogram: frequency by time         38.2 s <

 Memory estimate: 3.13 GiB, allocs estimate: 74250288.

HYBRID - B[20]
Mean Comfort = 0.9440877054912669, Mean NormCost = 0.8858661444044644
MOA in Hybrid executed for 2 times with 123 loads, limited to 5 iterations, demand scale = 0.9

BenchmarkTools.Trial: 25 samples with 1 evaluation.
 Range (min … max):  15.800 s …   17.031 s  ┊ GC (min … max): 1.23% … 1.51%
 Time  (median):     16.068 s               ┊ GC (median):    1.50%
 Time  (mean ± σ):   16.124 s ± 281.248 ms  ┊ GC (mean ± σ):  1.42% ± 0.18%

     ▁   ▁█     ▁▁   ▁
  ▆▁▁█▆▁▁██▁▆▆▆▁██▁▆▆█▁▆▁▁▁▁▁▁▁▁▆▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▆▁▁▁▁▁▁▁▁▆ ▁
  15.8 s          Histogram: frequency by time           17 s <

 Memory estimate: 1.22 GiB, allocs estimate: 28035690.

# 750 random LOADS

GEOFINDER – B[21]
Mean Comfort = 0.9544973455513059, Mean NormCost = 0.885632940326576

BenchmarkTools.Trial: 25 samples with 1 evaluation.
 Range (min … max):  309.100 μs … 377.100 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     312.000 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   319.320 μs ±  18.712 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▂▂█       
  ███▄▆▁▆▁▁▄▄▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▄▁▁▁▁▁▁▁▁▁▁▄▁▁▁▁▁▁▄ ▁
  309 μs           Histogram: frequency by time          377 μs <

 Memory estimate: 97.38 KiB, allocs estimate: 3719.

MOA NO DEMAND - B[22]
Mean Comfort = 0.9401988131896606, Mean NormCost = 0.8469380416492673

BenchmarkTools.Trial: 15 samples with 1 evaluation.
 Range (min … max):  6.154 s …    8.206 s  ┊ GC (min … max): 15.17% … 30.54%
 Time  (median):     6.525 s               ┊ GC (median):    15.89%
 Time  (mean ± σ):   6.699 s ± 594.260 ms  ┊ GC (mean ± σ):  18.24% ±  5.11%

          ▃▃  █   
  ▇▁▁▇▇▁▁▁██▇▇█▁▁▁▇▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▇▁▁▁▁▇ ▁
  6.15 s         Histogram: frequency by time         8.21 s <

 Memory estimate: 3.67 GiB, allocs estimate: 80863966.

MOA WITH DEMAND NO INITIALIZATION - B[23]
Mean Comfort = 0.9410324265947129, Mean NormCost = 0.8486072582247249

BenchmarkTools.Trial: 22 samples with 1 evaluation.
 Range (min … max):  91.284 s …   93.604 s  ┊ GC (min … max): 2.32% … 2.33%
 Time  (median):     92.362 s               ┊ GC (median):    2.29%
 Time  (mean ± σ):   92.339 s ± 548.134 ms  ┊ GC (mean ± σ):  2.27% ± 0.18%

  ▃              ▃ ▃           █
  █▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁█▁▇▇▁▇▁▁▇▇▁▇█▁▁▇▁▇▁▁▇▇▇▁▁▁▁▁▁▁▁▁▁▇▁▁▁▁▁▁▁▇ ▁
  91.3 s          Histogram: frequency by time         93.6 s <

 Memory estimate: 5.93 GiB, allocs estimate: 146133549.

MOA WITH DEMAND INITIALIZED WITH GEOFINDER - B[24]
Mean Comfort = 0.9410324265947129, Mean NormCost = 0.8486072582247249

BenchmarkTools.Trial: 24 samples with 1 evaluation.
 Range (min … max):  83.063 s … 92.177 s  ┊ GC (min … max): 1.77% … 2.26%
 Time  (median):     84.655 s             ┊ GC (median):    2.48%
 Time  (mean ± σ):   84.897 s ±  1.698 s  ┊ GC (mean ± σ):  2.43% ± 0.24%

     ▃ ▃▃▃ ██▃▃
  ▇▁▁█▁███▁████▇▇▁▇▁▇▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▇ ▁
  83.1 s         Histogram: frequency by time        92.2 s <

 Memory estimate: 5.93 GiB, allocs estimate: 146125698.

HYBRID - B[25]
Mean Comfort = 0.9461439865428813, Mean NormCost = 0.8623114111212535
MOA in Hybrid executed for 2 times with 217 loads, limited to 5 iterations, demand scale = 0.95

BenchmarkTools.Trial: 25 samples with 1 evaluation.
 Range (min … max):  37.821 s …   40.890 s  ┊ GC (min … max): 1.32% … 3.17%
 Time  (median):     38.451 s               ┊ GC (median):    1.45%
 Time  (mean ± σ):   38.664 s ± 667.657 ms  ┊ GC (mean ± σ):  1.78% ± 0.83%

         ▁▄ ▄ █   ▁
  ▆▁▁▁▁▆▁██▆█▆█▁▁▁█▆▁▁▆▁▁▆▁▁▁▁▁▆▁▁▁▁▆▁▁▁▁▁▆▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▆ ▁
  37.8 s          Histogram: frequency by time         40.9 s <

 Memory estimate: 2.67 GiB, allocs estimate: 62802981.

# 25 random LOADS

GEOFINDER – B[26]
Mean Comfort = 0.9639094809094808, Mean NormCost = 0.9230197173139565

BenchmarkTools.Trial: 100 samples with 4 evaluations.
 Range (min … max):   7.850 μs … 22.425 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):      8.488 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   10.074 μs ±  3.063 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▃██▂▂           ▃▁▂
  █████▅▅▅▅▁▁▅▁▁▁▁███▁▇▅▁▁▁▅▁▁▁▅▁▁▁▅▁▁▁▅▁▇▁▁▁▁▁▅▅▁▁▁▁▁▁▁▁▁▁▁▅ ▅
  7.85 μs      Histogram: log(frequency) by time      21.8 μs <

 Memory estimate: 3.66 KiB, allocs estimate: 150.

MOA NO DEMAND - B[27]
Mean Comfort = 0.948171976487766, Mean NormCost = 0.8932962131930267

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  52.094 ms … 148.151 ms  ┊ GC (min … max): 0.00% …  0.00%
 Time  (median):     61.573 ms               ┊ GC (median):    0.00%
 Time  (mean ± σ):   65.340 ms ±  15.461 ms  ┊ GC (mean ± σ):  4.79% ± 11.08%

      ▃█  █▇▃▂                                                  
  ▃▁▅▆███▆████▅▄▄▆▁▃▁▃▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▃▁▁▁▄▁▄ ▃
  52.1 ms         Histogram: frequency by time          116 ms <

 Memory estimate: 19.09 MiB, allocs estimate: 347771.

MOA WITH DEMAND NO INITIALIZATION - B[28]
Mean Comfort = 0.9450894177234609, Mean NormCost = 0.8932962131930267

BenchmarkTools.Trial: 78 samples with 1 evaluation.
 Range (min … max):  1.188 s …    1.796 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     1.250 s               ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.285 s ± 108.193 ms  ┊ GC (mean ± σ):  1.13% ± 1.62%

   ▄██▄▄█ ▁ ▃ ▃
  ▄██████▄█▇█▄█▆▄▄▄▁▇▁▁▁▄▄▁▄▁▁▁▁▁▄▁▁▁▁▄▁▁▁▄▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▄ ▁
  1.19 s         Histogram: frequency by time         1.74 s <

 Memory estimate: 92.67 MiB, allocs estimate: 2340138.

MOA WITH DEMAND INITIALIZED WITH GEOFINDER - B[29]
Mean Comfort = 0.9450894177234609, Mean NormCost = 0.8932962131930267

BenchmarkTools.Trial: 80 samples with 1 evaluation.
 Range (min … max):  1.202 s …   1.621 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     1.243 s              ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.256 s ± 55.580 ms  ┊ GC (mean ± σ):  1.17% ± 1.66%

    ▁ █▁ ▃▃▆▁  ▁
  ▆▄█▇██▇████▇▄█▇▄▇▇▆▆▁▁▆▄▁▇▄▄▁▁▄▁▁▄▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▄ ▁
  1.2 s          Histogram: frequency by time        1.44 s <

 Memory estimate: 92.64 MiB, allocs estimate: 2340086.

HYBRID - B[30]
Mean Comfort = 0.9574150417544913, Mean NormCost = 0.9149488437502726
MOA in Hybrid executed for 1 times with 14 loads, limited to 5 iterations, demand scale = 0.95

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  779.227 ms …   1.221 s  ┊ GC (min … max): 0.00% … 5.05%
 Time  (median):     809.448 ms              ┊ GC (median):    0.00%
 Time  (mean ± σ):   821.517 ms ± 47.871 ms  ┊ GC (mean ± σ):  1.07% ± 1.95%

        ▂ ▄▂█▂ ▄▆▂▂█▂▂  ▂
  ▄▁▄▄▁▁██████▄███████▄▄█▆▁▄▁▁▆▁▄▄▁▁▁▁▆▄▄▁▆▄▁▄▆▄▄▄▄▄▁▁▁█▁▄▁▄▁▄ ▄
  779 ms          Histogram: frequency by time          886 ms <

 Memory estimate: 60.82 MiB, allocs estimate: 1417806.

# 75 random LOADS

GEOFINDER – B[31]
Mean Comfort = 0.965594157994735, Mean NormCost = 0.8731028016424748

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  17.800 μs … 45.300 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     18.700 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   19.975 μs ±  4.019 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▁█▆    
  ███▆▅▃▁▁▂▁▂▁▂▁▁▁▁▁▁▂▄▃▂▂▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▂ ▂
  17.8 μs         Histogram: frequency by time        39.5 μs <

 Memory estimate: 7.50 KiB, allocs estimate: 280.

MOA NO DEMAND - B[32]
Mean Comfort = 0.9641357587807503, Mean NormCost = 0.8520352126644017
BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  146.323 ms … 269.027 ms  ┊ GC (min … max): 0.00% … 21.46%
 Time  (median):     166.986 ms               ┊ GC (median):    0.00%
 Time  (mean ± σ):   178.618 ms ±  30.085 ms  ┊ GC (mean ± σ):  8.15% ± 11.10%

   ▃▁▄  ▆ ▄ ▁▁ █ ▃                        ▁
  ▇███▆▆█▇█▇██▇█▇█▁▄▁▁▁▄▆▁▁▁▁▁▁▁▁▁▁▇▁▁▁▆▁▄█▁▁▄▇▄▄▁▄▆▇▆▁▁▄▁▁▄▁▁▄ ▄
  146 ms           Histogram: frequency by time          248 ms <

 Memory estimate: 72.37 MiB, allocs estimate: 1427439.

MOA WITH DEMAND NO INITIALIZATION - B[33]
Mean Comfort = 0.9623237967523719, Mean NormCost = 0.8522446853593528

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  3.822 s …    5.029 s  ┊ GC (min … max): 1.17% … 0.80%
 Time  (median):     3.902 s               ┊ GC (median):    1.20%
 Time  (mean ± σ):   3.933 s ± 142.631 ms  ┊ GC (mean ± σ):  1.17% ± 0.24%

      ▄▁▁█▆▂▇  ▂
  ▄▃▆████████▇▄█▃▄▃▁▄▄▁▁▁▁▁▃▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▃▁▁▁▁▁▁▁▃▁▁▁▃▁▁▁▃ ▃
  3.82 s         Histogram: frequency by time         4.36 s <

 Memory estimate: 273.62 MiB, allocs estimate: 6894608.

MOA WITH DEMAND INITIALIZED WITH GEOFINDER - B[34]
Mean Comfort = 0.9623237967523719, Mean NormCost = 0.8522446853593528

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  3.611 s …   4.166 s  ┊ GC (min … max): 0.00% … 1.06%
 Time  (median):     3.692 s              ┊ GC (median):    1.13%
 Time  (mean ± σ):   3.715 s ± 89.649 ms  ┊ GC (mean ± σ):  1.10% ± 0.25%

        ▃▄██▁  ▁                                             
  ▄▁▁▆▆▆█████▆▆█▄▃▃▁▆▁▁▁▃▁▁▁▁▁▃▃▁▃▁▁▁▁▃▁▃▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▃ ▃
  3.61 s         Histogram: frequency by time        4.11 s <

 Memory estimate: 273.53 MiB, allocs estimate: 6894512.

HYBRID - B[35]
Mean Comfort = 0.9631459800762635, Mean NormCost = 0.8731028016424748
MOA in Hybrid executed for 2 times with 19 loads, limited to 5 iterations, demand scale = 0.95

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  1.714 s …    2.452 s  ┊ GC (min … max): 0.00% … 3.48%
 Time  (median):     1.802 s               ┊ GC (median):    1.93%
 Time  (mean ± σ):   1.829 s ± 112.209 ms  ┊ GC (mean ± σ):  1.19% ± 1.10%

     ▂ █▂ ▄ ▆▃ 
  ▃▅▁█▆████▇██▅▃▆▄▄▃▁▃▁▁▃▃▁▅▁▁▁▁▁▁▃▁▁▁▁▄▁▃▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▃ ▃
  1.71 s         Histogram: frequency by time         2.27 s <

 Memory estimate: 153.42 MiB, allocs estimate: 3424844.

# 250 random LOADS

GEOFINDER – B[36]
Mean Comfort = 0.9686602443650579, Mean NormCost = 0.8814729522448811

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):   99.000 μs … 128.500 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     101.250 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   102.471 μs ±   4.588 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

    ▃▁█▁▂  
  ▇▇█████▇▄▄▅▄▄▄▄▁▄▁▃▁▄▁▁▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▃ ▃
  99 μs            Histogram: frequency by time          125 μs <

 Memory estimate: 31.16 KiB, allocs estimate: 1182.

MOA NO DEMAND - B[37]
Mean Comfort = 0.9597947104532378, Mean NormCost = 0.8471496564591503

BenchmarkTools.Trial: 100 samples with 1 evaluation.
 Range (min … max):  870.018 ms …   1.262 s  ┊ GC (min … max):  8.55% … 12.45%
 Time  (median):     955.984 ms              ┊ GC (median):    14.49%
 Time  (mean ± σ):   961.677 ms ± 59.026 ms  ┊ GC (mean ± σ):  13.15% ±  2.82%

    ▁▄      ▁▁█▃▆▁▁ ▄ ▄ ▃▆
  ▇▄██▄▄▆▁▄▆███████▇█▇█▇██▇▁▄▆▁▁▁▁▁▁▁▄▁▁▁▁▁▄▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▄ ▄
  870 ms          Histogram: frequency by time          1.21 s <

 Memory estimate: 508.57 MiB, allocs estimate: 10688015.

MOA WITH DEMAND NO INITIALIZATION - B[38]
Mean Comfort = 0.9588104658178256, Mean NormCost = 0.8477152327355184

BenchmarkTools.Trial: 50 samples with 1 evaluation.
 Range (min … max):  16.501 s …   17.951 s  ┊ GC (min … max): 1.39% … 1.80%
 Time  (median):     16.864 s               ┊ GC (median):    1.61%
 Time  (mean ± σ):   16.958 s ± 347.121 ms  ┊ GC (mean ± σ):  2.05% ± 1.24%

  ▃▃  ▃ █ ███ ▃ █ ▃ █  ▃        ▃▃        ▃
  ██▁▇█▁█▇███▁█▁█▇█▁█▇▇█▇▁▇▁▁▁▇▇██▁▁▁▇▁▁▁▁█▇▁▁▁▇▁▁▁▁▁▁▁▁▁▇▁▁▇ ▁
  16.5 s          Histogram: frequency by time           18 s <

 Memory estimate: 1.21 GiB, allocs estimate: 29612248.

MOA WITH DEMAND INITIALIZED WITH GEOFINDER - B[39]
Mean Comfort = 0.9588104658178256, Mean NormCost = 0.8477152327355184

BenchmarkTools.Trial: 50 samples with 1 evaluation.
 Range (min … max):  16.534 s …   18.245 s  ┊ GC (min … max): 1.63% … 1.46%
 Time  (median):     16.779 s               ┊ GC (median):    1.61%
 Time  (mean ± σ):   16.919 s ± 412.275 ms  ┊ GC (mean ± σ):  2.01% ± 1.20%

  ▅▅▂█  ▂ ▂ ▂   
  █████▅█▅█▅███▅▁█▅▅▅▅▁▁▁▁▁▁▅▁▁▁▁▅▁█▁▁▅▁▁▅▅▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▅▁▅ ▁
  16.5 s          Histogram: frequency by time         18.2 s <

 Memory estimate: 1.21 GiB, allocs estimate: 29611768.

HYBRID - B[40]
Mean Comfort = 0.9679278437007202, Mean NormCost = 0.8814729522448811
MOA in Hybrid executed for 1 times with 75 loads, limited to 5 iterations, demand scale = 0.95

BenchmarkTools.Trial: 50 samples with 1 evaluation.
 Range (min … max):  3.973 s …   4.313 s  ┊ GC (min … max): 0.00% … 1.13%
 Time  (median):     4.044 s              ┊ GC (median):    1.20%
 Time  (mean ± σ):   4.061 s ± 63.910 ms  ┊ GC (mean ± σ):  1.19% ± 0.31%

       ▃ █▃▃ ▃  ▁  ▆
  ▄▁▄▁▁█▁███▇█▁▇█▇▇█▄▇▁▄▄▁▁▄▁▁▁▁▁▁▁▁▁▁▄▄▁▁▁▁▁▁▁▁▁▁▄▁▁▁▁▁▁▁▄ ▁
  3.97 s         Histogram: frequency by time        4.31 s <

 Memory estimate: 303.17 MiB, allocs estimate: 6868449.
