# export JULIA_NUM_THREADS=‘4’

using Base.Threads: @threads, nthreads, threadid


# threadpool (generic function with 2 methods)


threadpool(fn_map, array) =
  begin
    array_return = Array[[] for _ in 1:nthreads()]
    @threads for e in array
        push!(array_return[threadid()], fn_map(e))
    end ; array_return = vcat(array_return...)

  array_return
  end


threadpool(fn_aggregate, fn_map, array) =
  begin
      array_return = Array[[] for _ in 1:nthreads()]
      @threads for e in array
          push!(array_return[threadid()], fn_map(e))
      end ; array_return = vcat(array_return...)
      value_return = fn_aggregate(array_return)

  value_return
  end
