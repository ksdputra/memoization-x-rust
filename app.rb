require 'benchmark'
require 'benchmark/memory'
require 'memoist'
require 'memery'
require 'ffi'

class Normal
  def fib(n)
    return 0 if n <= 0
    return 1 if n ==  1
    return fib(n-2) + fib(n-1)
  end
end

class MemHash
  def initialize
    @fib = {}
  end

  def fib(n)
    return 0 if n <= 0
    return 1 if n ==  1
    return @fib[n] if @fib[n]
    @fib[n] = fib(n-2) + fib(n-1)
    return @fib[n]
  end
end

class MeMoist
  extend Memoist
  def fib(n)
    return 0 if n <= 0
    return 1 if n ==  1
    return fib(n-2) + fib(n-1)
  end
  memoize :fib
end

class MeMery
  include Memery

  memoize def fib(n)
    return 0 if n <= 0
    return 1 if n ==  1
    return fib(n-2) + fib(n-1)
  end
end

module RustNor
  extend FFI::Library
  ffi_lib './libfibonacci.so'
  attach_function :fibonacci, [:int], :int
end

# module RustMem
#   extend FFI::Library
#   ffi_lib './libfib_memo.so'
#   attach_function :fib_memo, [:pointer, :int], :int
#   # TODO search how to pass 2 arguments, and hash as an argument
# end

print 'Input number (recommend: 40) #> '
n = gets.chomp.to_i
puts 'Working on it...'
puts "Normal  : #{Normal.new.fib(n)}"
puts "MemHash : #{MemHash.new.fib(n)}"
puts "Memoist : #{MeMoist.new.fib(n)}"
puts "Memery  : #{MeMery.new.fib(n)}"
puts "RustNor : #{RustNor.fibonacci(n)}"
# puts "RustMem : #{RustMem.fib_memo({}, n)}"
puts "\n1st Benchmarking..."
Benchmark.bmbm do |x|
  # x.report("Normal ") { Normal.new.fib(n) }
  x.report("MemHash") { MemHash.new.fib(n) }
  x.report("Memoist") { MeMoist.new.fib(n) }
  x.report("Memery ") { MeMery.new.fib(n) }
  x.report("RustNor") { RustNor.fibonacci(n) }
  # x.report("RustMem") { RustMem.fib_memo({}, n) }
end
puts "\n2nd Benchmarking..."
Benchmark.memory do |x|
  # x.report("Normal ") { Normal.new.fib(n) }
  x.report("MemHash") { MemHash.new.fib(n) }
  x.report("Memoist") { MeMoist.new.fib(n) }
  x.report("Memery ") { MeMery.new.fib(n) }
  x.report("RustNor") { RustNor.fibonacci(n) }
  # x.report("RustMem") { RustMem.fib_memo({}, n) }

  x.compare!
end