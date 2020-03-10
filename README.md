This is the beginning: https://medium.com/@fbzga/rust-to-the-rescue-of-ruby-2067f5e1dc25

The post about how Rust can be combined with Ruby when performance is the goal. The author use fibonacci as case study. Then someone commenting: "Why don't you use memoization? You, as programmer, should think about algorithm rather than use other tools," Well, at least read the disclaimer before commenting.

But I became aware of memoization. So I want to do some research: 

1. Which is fastest, embedding rust or use memoization?
2. Can I use memoization in many of my projects?

Let's see:

Dependencies:
1. Ruby 2.6.5

Fibonacci 25:
```
Input number (recommend: 40) #> 25
Working on it...
Normal  : 75025
MemHash : 75025
Memoist : 75025
Memery  : 75025
RustNor : 75025

1st Benchmarking...
Rehearsal -------------------------------------------
Normal    0.016503   0.000027   0.016530 (  0.016605)
MemHash   0.000027   0.000002   0.000029 (  0.000026)
Memoist   0.000183   0.000012   0.000195 (  0.000198)
Memery    0.000228   0.000015   0.000243 (  0.000244)
RustNor   0.000241   0.000000   0.000241 (  0.000245)
---------------------------------- total: 0.017238sec

              user     system      total        real
Normal    0.012602   0.000000   0.012602 (  0.012611)
MemHash   0.000025   0.000000   0.000025 (  0.000020)
Memoist   0.000129   0.000000   0.000129 (  0.000124)
Memery    0.000216   0.000000   0.000216 (  0.000213)
RustNor   0.000195   0.000000   0.000195 (  0.000211)

2nd Benchmarking...
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
Input number (recommend: 40) #> 40
Working on it...
Normal  : 102334155
MemHash : 102334155
Memoist : 102334155
Memery  : 102334155
RustNor : 102334155

1st Benchmarking...
Rehearsal -------------------------------------------
Normal   13.058228   0.095922  13.154150 ( 13.163158)
MemHash   0.000041   0.000001   0.000042 (  0.000040)
Memoist   0.000313   0.000003   0.000316 (  0.000318)
Memery    0.000256   0.000003   0.000259 (  0.000259)
RustNor   0.209099   0.004009   0.213108 (  0.213135)
--------------------------------- total: 13.367875sec

              user     system      total        real
Normal   12.990388   0.103949  13.094337 ( 13.100598)
MemHash   0.000193   0.000000   0.000193 (  0.000189)
Memoist   0.000206   0.000000   0.000206 (  0.000202)
Memery    0.000162   0.000000   0.000162 (  0.000160)
RustNor   0.209382   0.000000   0.209382 (  0.209426)

2nd Benchmarking...
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

Fibonacci 75:
```
Input number (recommend: 40) #> 75
Working on it...
MemHash : 2111485077978050
Memoist : 2111485077978050
Memery  : 2111485077978050

1st Benchmarking...
Rehearsal -------------------------------------------
MemHash   0.000095   0.000028   0.000123 (  0.000114)
Memoist   0.000879   0.000263   0.001142 (  0.001144)
Memery    0.000949   0.000000   0.000949 (  0.000947)
---------------------------------- total: 0.002214sec

              user     system      total        real
MemHash   0.000272   0.000003   0.000275 (  0.000270)
Memoist   0.000538   0.000000   0.000538 (  0.000533)
Memery    0.000437   0.000000   0.000437 (  0.000433)

2nd Benchmarking...
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

1st Benchmarking...
Rehearsal -------------------------------------------
MemHash   0.000301   0.000118   0.000419 (  0.000405)
Memoist   0.004125   0.000000   0.004125 (  0.004188)
Memery    0.002452   0.000000   0.002452 (  0.002447)
---------------------------------- total: 0.006996sec

              user     system      total        real
MemHash   0.000424   0.000000   0.000424 (  0.000419)
Memoist   0.001235   0.000000   0.001235 (  0.001252)
Memery    0.000708   0.000000   0.000708 (  0.000748)

2nd Benchmarking...
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