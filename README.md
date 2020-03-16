The idea start from here: https://medium.com/@fbzga/rust-to-the-rescue-of-ruby-2067f5e1dc25

The post about how Rust can be combined with Ruby when performance is the goal. The author use fibonacci as case study. Then someone commenting: "Why don't you use memoization? You, as programmer, should think about algorithm rather than use other tools," Well, at least read the disclaimer before commenting.

But I became aware of memoization. So I want to do some research: 

1. Which is fastest, embedding rust or use memoization?
2. Can I use memoization in many of my projects?

Let's see:

Dependencies:
1. Ruby 2.6.5

Desription:
1. Normal  -> Ruby the normal way without memoization
2. MemHash -> Ruby using hash to memoize
3. Memoist -> Ruby using gem memoist to memoize
4. Memery  -> Ruby using gem memery to memoize
5. RustNor -> Rust the normal way without memoization

Fibonacci 15:
```
Input number (recommend: 40) #> 15
Working on it...
Normal  : 610
MemHash : 610
Memoist : 610
Memery  : 610
RustNor : 610

1st Benchmarking... (computation time)
Rehearsal -------------------------------------------
Normal    0.000082   0.000025   0.000107 (  0.000105)
MemHash   0.000008   0.000002   0.000010 (  0.000010)
Memoist   0.000052   0.000016   0.000068 (  0.000068)
Memery    0.000048   0.000015   0.000063 (  0.000063)
RustNor   0.000005   0.000001   0.000006 (  0.000006)
---------------------------------- total: 0.000254sec

              user     system      total        real
Normal    0.000091   0.000000   0.000091 (  0.000089)
MemHash   0.000013   0.000000   0.000013 (  0.000012)
Memoist   0.000077   0.000000   0.000077 (  0.000076)
Memery    0.000122   0.000000   0.000122 (  0.000121)
RustNor   0.000010   0.000000   0.000010 (  0.000008)

2nd Benchmarking... (iteration per second)
Warming up --------------------------------------
             Normal      1.277k i/100ms
             MemHash    26.560k i/100ms
             Memoist     1.924k i/100ms
             Memery      1.927k i/100ms
             RustNor    65.905k i/100ms
Calculating -------------------------------------
             Normal      12.279k (± 7.7%) i/s -     61.296k in   5.025654s
             MemHash    281.549k (± 2.4%) i/s -      1.408M in   5.002863s
             Memoist     19.520k (± 1.4%) i/s -     98.124k in   5.027731s
             Memery      19.759k (± 1.4%) i/s -    100.204k in   5.072236s
             RustNor    754.988k (± 1.2%) i/s -      3.822M in   5.063670s

Comparison:
             RustNor:   754988.3 i/s
             MemHash:   281548.7 i/s - 2.68x  slower
             Memery :    19759.5 i/s - 38.21x  slower
             Memoist:    19520.2 i/s - 38.68x  slower
             Normal :    12278.5 i/s - 61.49x  slower


3rd Benchmarking... (memory allocation)
Calculating -------------------------------------
             Normal     40.000  memsize (     0.000  retained)
                         1.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             MemHash   968.000  memsize (     0.000  retained)
                         2.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             Memoist     5.376k memsize (    40.000  retained)
                        89.000  objects (     1.000  retained)
                         1.000  strings (     0.000  retained)
             Memery      6.072k memsize (     0.000  retained)
                        48.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             RustNor     0.000  memsize (     0.000  retained)
                         0.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)

Comparison:
             RustNor:          0 allocated
             Normal :         40 allocated - Infx more
             MemHash:        968 allocated - Infx more
             Memoist:       5376 allocated - Infx more
             Memery :       6072 allocated - Infx more
```

Fibonacci 25:
```
Input number (recommend: 40) #> 25
Working on it...
Normal  : 75025
MemHash : 75025
Memoist : 75025
Memery  : 75025
RustNor : 75025

1st Benchmarking... (computation time)
Rehearsal -------------------------------------------
Normal    0.009896   0.000000   0.009896 (  0.009897)
MemHash   0.000016   0.000000   0.000016 (  0.000014)
Memoist   0.000108   0.000000   0.000108 (  0.000109)
Memery    0.000129   0.000000   0.000129 (  0.000128)
RustNor   0.000190   0.000000   0.000190 (  0.000189)
---------------------------------- total: 0.010339sec

              user     system      total        real
Normal    0.010088   0.000000   0.010088 (  0.010092)
MemHash   0.000024   0.000000   0.000024 (  0.000019)
Memoist   0.000140   0.000000   0.000140 (  0.000139)
Memery    0.000133   0.000000   0.000133 (  0.000132)
RustNor   0.000186   0.000000   0.000186 (  0.000185)

2nd Benchmarking... (iteration per second)
Warming up --------------------------------------
             Normal     10.000  i/100ms
             MemHash    15.943k i/100ms
             Memoist     1.150k i/100ms
             Memery      1.175k i/100ms
             RustNor   661.000  i/100ms
Calculating -------------------------------------
             Normal     103.897  (± 1.0%) i/s -    520.000  in   5.005418s
             MemHash    163.135k (± 8.1%) i/s -    813.093k in   5.035707s
             Memoist     11.605k (± 1.4%) i/s -     58.650k in   5.054767s
             Memery      11.632k (± 7.0%) i/s -     58.750k in   5.086413s
             RustNor      6.657k (± 2.8%) i/s -     33.711k in   5.068621s

Comparison:
             MemHash:   163135.4 i/s
             Memery :    11631.5 i/s - 14.03x  slower
             Memoist:    11605.1 i/s - 14.06x  slower
             RustNor:     6657.3 i/s - 24.50x  slower
             Normal :      103.9 i/s - 1570.16x  slower


3rd Benchmarking... (memory allocation)
Calculating -------------------------------------
             Normal     40.000  memsize (     0.000  retained)
                         1.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             MemHash   968.000  memsize (     0.000  retained)
                         2.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             Memoist     8.416k memsize (    40.000  retained)
                       149.000  objects (     1.000  retained)
                         1.000  strings (     0.000  retained)
             Memery      9.192k memsize (     0.000  retained)
                        78.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             RustNor     0.000  memsize (     0.000  retained)
                         0.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)

Comparison:
             RustNor:          0 allocated
             Normal :         40 allocated - Infx more
             MemHash:        968 allocated - Infx more
             Memoist:       8416 allocated - Infx more
             Memery :       9192 allocated - Infx more
```

Fibonacci 40:
```
Working on it...
Normal  : 102334155
MemHash : 102334155
Memoist : 102334155
Memery  : 102334155
RustNor : 102334155

1st Benchmarking... (computation time)
Rehearsal -------------------------------------------
Normal   13.694384   0.000000  13.694384 ( 13.694409)
MemHash   0.000045   0.000000   0.000045 (  0.000045)
Memoist   0.000218   0.000000   0.000218 (  0.000219)
Memery    0.000204   0.000000   0.000204 (  0.000204)
RustNor   0.205440   0.000000   0.205440 (  0.205448)
--------------------------------- total: 13.900291sec

              user     system      total        real
Normal   13.932361   0.000000  13.932361 ( 13.932435)
MemHash   0.000077   0.000000   0.000077 (  0.000074)
Memoist   0.000220   0.000000   0.000220 (  0.000219)
Memery    0.000202   0.000000   0.000202 (  0.000201)
RustNor   0.204110   0.000000   0.204110 (  0.204115)

2nd Benchmarking... (iteration per second)
Warming up --------------------------------------
             Normal      1.000  i/100ms
             MemHash     9.549k i/100ms
             Memoist   706.000  i/100ms
             Memery    726.000  i/100ms
             RustNor     1.000  i/100ms
Calculating -------------------------------------
             Normal       0.075  (± 0.0%) i/s -      1.000  in  13.329450s
             MemHash     98.831k (± 1.8%) i/s -    496.548k in   5.025948s
             Memoist      7.111k (± 1.3%) i/s -     36.006k in   5.064540s
             Memery       7.315k (± 1.2%) i/s -     37.026k in   5.062057s
             RustNor      4.892  (± 0.0%) i/s -     25.000  in   5.110503s

Comparison:
             MemHash:    98830.9 i/s
             Memery :     7315.4 i/s - 13.51x  slower
             Memoist:     7110.7 i/s - 13.90x  slower
             RustNor:        4.9 i/s - 20201.69x  slower
             Normal :        0.1 i/s - 1317362.03x  slower


3rd Benchmarking... (memory allocation)
Calculating -------------------------------------
             Normal     40.000  memsize (     0.000  retained)
                         1.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             MemHash     1.800k memsize (     0.000  retained)
                         2.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             Memoist    13.808k memsize (    40.000  retained)
                       239.000  objects (     1.000  retained)
                         1.000  strings (     0.000  retained)
             Memery     14.704k memsize (     0.000  retained)
                       123.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             RustNor     0.000  memsize (     0.000  retained)
                         0.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)

Comparison:
             RustNor:          0 allocated
             Normal :         40 allocated - Infx more
             MemHash:       1800 allocated - Infx more
             Memoist:      13808 allocated - Infx more
             Memery :      14704 allocated - Infx more
```

Fibonacci 50:
```
Input number (recommend: 40) #> 50
Working on it...
MemHash : 12586269025
Memoist : 12586269025
Memery  : 12586269025

1st Benchmarking... (computation time)
Rehearsal -------------------------------------------
MemHash   0.000049   0.000000   0.000049 (  0.000047)
Memoist   0.000229   0.000000   0.000229 (  0.000212)
Memery    0.000207   0.000000   0.000207 (  0.000207)
---------------------------------- total: 0.000485sec

              user     system      total        real
MemHash   0.000052   0.000000   0.000052 (  0.000050)
Memoist   0.000246   0.000000   0.000246 (  0.000245)
Memery    0.000225   0.000000   0.000225 (  0.000222)

2nd Benchmarking... (iteration per second)
Warming up --------------------------------------
             MemHash     7.796k i/100ms
             Memoist   563.000  i/100ms
             Memery    582.000  i/100ms
Calculating -------------------------------------
             MemHash     79.300k (± 1.5%) i/s -    397.596k in   5.015072s
             Memoist      5.661k (± 1.9%) i/s -     28.713k in   5.074156s
             Memery       5.708k (± 3.6%) i/s -     28.518k in   5.002428s

Comparison:
             MemHash:    79299.8 i/s
             Memery :     5708.5 i/s - 13.89x  slower
             Memoist:     5660.9 i/s - 14.01x  slower


3rd Benchmarking... (memory allocation)
Calculating -------------------------------------
             MemHash     1.800k memsize (     0.000  retained)
                         2.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             Memoist    16.848k memsize (    40.000  retained)
                       299.000  objects (     1.000  retained)
                         1.000  strings (     0.000  retained)
             Memery     17.824k memsize (     0.000  retained)
                       153.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)

Comparison:
             MemHash:       1800 allocated
             Memoist:      16848 allocated - 9.36x more
             Memery :      17824 allocated - 9.90x more
```

Fibonacci 75:
```
Input number (recommend: 40) #> 75
Working on it...
MemHash : 2111485077978050
Memoist : 2111485077978050
Memery  : 2111485077978050

1st Benchmarking... (computation time)
Rehearsal -------------------------------------------
MemHash   0.000033   0.000000   0.000033 (  0.000029)
Memoist   0.000353   0.000000   0.000353 (  0.000354)
Memery    0.000348   0.000000   0.000348 (  0.000349)
---------------------------------- total: 0.000734sec

              user     system      total        real
MemHash   0.000062   0.000000   0.000062 (  0.000058)
Memoist   0.000336   0.000000   0.000336 (  0.000336)
Memery    0.000304   0.000001   0.000305 (  0.000303)

2nd Benchmarking... (iteration per second)
Warming up --------------------------------------
             MemHash     4.884k i/100ms
             Memoist   369.000  i/100ms
             Memery    382.000  i/100ms
Calculating -------------------------------------
             MemHash     50.027k (± 1.2%) i/s -    253.968k in   5.077362s
             Memoist      3.730k (± 1.4%) i/s -     18.819k in   5.045915s
             Memery       3.811k (± 4.7%) i/s -     19.100k in   5.024862s

Comparison:
             MemHash:    50027.0 i/s
             Memery :     3811.0 i/s - 13.13x  slower
             Memoist:     3730.3 i/s - 13.41x  slower


3rd Benchmarking... (memory allocation)
Calculating -------------------------------------
             MemHash     3.464k memsize (     0.000  retained)
                         2.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             Memoist    26.112k memsize (    40.000  retained)
                       449.000  objects (     1.000  retained)
                         1.000  strings (     0.000  retained)
             Memery     27.288k memsize (     0.000  retained)
                       228.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)

Comparison:
             MemHash:       3464 allocated
             Memoist:      26112 allocated - 7.54x more
             Memery :      27288 allocated - 7.88x more
```

Fibonacci 100:
```
Input number (recommend: 40) #> 100
Working on it...
MemHash : 354224848179261915075
Memoist : 354224848179261915075
Memery  : 354224848179261915075

1st Benchmarking... (computation time)
Rehearsal -------------------------------------------
MemHash   0.000047   0.000000   0.000047 (  0.000042)
Memoist   0.000391   0.000000   0.000391 (  0.000392)
Memery    0.000379   0.000000   0.000379 (  0.000379)
---------------------------------- total: 0.000817sec

              user     system      total        real
MemHash   0.000082   0.000000   0.000082 (  0.000077)
Memoist   0.000418   0.000000   0.000418 (  0.000417)
Memery    0.000399   0.000000   0.000399 (  0.000398)

2nd Benchmarking... (iteration per second)
Warming up --------------------------------------
             MemHash     3.684k i/100ms
             Memoist   275.000  i/100ms
             Memery    285.000  i/100ms
Calculating -------------------------------------
             MemHash     37.464k (± 1.5%) i/s -    187.884k in   5.016263s
             Memoist      2.794k (± 2.6%) i/s -     14.025k in   5.024220s
             Memery       2.878k (± 2.3%) i/s -     14.535k in   5.052557s

Comparison:
             MemHash:    37463.7 i/s
             Memery :     2878.3 i/s - 13.02x  slower
             Memoist:     2793.6 i/s - 13.41x  slower


3rd Benchmarking... (memory allocation)
Calculating -------------------------------------
             MemHash     3.864k memsize (    40.000  retained)
                        12.000  objects (     1.000  retained)
                         0.000  strings (     0.000  retained)
             Memoist    34.112k memsize (    80.000  retained)
                       609.000  objects (     2.000  retained)
                         1.000  strings (     0.000  retained)
             Memery     35.488k memsize (     0.000  retained)
                       313.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)

Comparison:
             MemHash:       3864 allocated
             Memoist:      34112 allocated - 8.83x more
             Memery :      35488 allocated - 9.18x more
```

Computation Time Comparison:

|Method |fib(15) |fib(25) |fib(40)  |fib(50) |fib(75) |fib(100)|
|-------|-------:|-------:|--------:|-------:|-------:|-------:|
|Normal |0.000089|0.010092|13.932435|     n/a|     n/a|     n/a|
|MemHash|0.000012|0.000019| 0.000074|0.000050|0.000058|0.000077|
|Memoist|0.000076|0.000139| 0.000219|0.000245|0.000336|0.000417|
|Memery |0.000121|0.000132| 0.000201|0.000222|0.000303|0.000398|
|RustNor|0.000008|0.000185| 0.204115|     n/a|     n/a|     n/a|

IPS Comparison:
|Method |fib(15)          |fib(25)          |fib(40)         |fib(50)         |fib(75)         |fib(100)        |
|-------|----------------:|----------------:|---------------:|---------------:|---------------:|---------------:|
|Normal | 12.279k (± 7.7%)|103.897  (± 1.0%)| 0.075  (± 0.0%)|             n/a|             n/a|             n/a|
|MemHash|281.549k (± 2.4%)|103.897  (± 1.0%)|98.831k (± 1.8%)|79.300k (± 1.5%)|50.027k (± 1.2%)|37.464k (± 1.5%)|
|Memoist| 19.520k (± 1.4%)| 11.605k (± 1.4%)| 7.111k (± 1.3%)| 5.661k (± 1.9%)| 3.730k (± 1.4%)| 2.794k (± 2.6%)|
|Memery | 19.759k (± 1.4%)| 11.632k (± 7.0%)| 7.315k (± 1.2%)| 5.708k (± 3.6%)| 3.811k (± 4.7%)| 2.878k (± 2.3%)|
|RustNor|754.988k (± 1.2%)|  6.657k (± 2.8%)| 4.892  (± 0.0%)|             n/a|             n/a|             n/a|

Memory Allocation Comparison:
|Method |fib(15)|fib(25)|fib(40)|fib(50)|fib(75)|fib(100)|
|-------|------:|------:|------:|------:|------:|-------:|
|Normal |     40|     40|     40|    n/a|    n/a|     n/a|
|MemHash|    968|    968|   1800|   1800|   3464|    3864|
|Memoist|   5376|   8416|  13808|  16848|  26112|   34112|
|Memery |   6072|   9192|  14704|  17824|  27288|   35488|
|RustNor|      0|      0|      0|    n/a|    n/a|     n/a|

Note:
1. I don't include Ruby normal for Fibonacci(>40), because the waiting time will be very very long;
2. I don't include Rust normal for Fibonacci(>45), because the calculation become weird. It produces negative integer. I don't write the code, I just copying from the article in the top;
3. I never include Rust memoize, because I still don't know how to use it using ffi gems;
4. I don't use multithreading, as my intention is to benchmarking the methods and feel it in the real world application.

Conclusion:
1. Using rust is faster than using ruby, but algorithm really take place. I believe if I compare ruby memoize vs rust memoize so the winner will be rust memoize;
2. Rust is literally has no GC! You can see the memory created when using Rust normal;
3. Memoization is sure improving performance, but with the cost of higher memory consumption. The bigger the fibonacci, the bigger the memory taken. Yeah, because we keep the value in memory, that's why memoization need much bigger memory allocation;
4. The best memoization for ruby is using hash rather than gems. Ruby Hash is faster and has fewer memory consumption than using existing gems;
5. Because of this nature, we have to use memoization with precaution: do we want to gain speed over memory allocation?