module Danica
  class Function::Gauss < Function.build(:x, median: :u, variance_root: { latex: '\theta', gnu: :v })

    private

    def function_block
      @function_block ||= product(parcels)
    end

    def parcels
      [
        division(1, denominator),
        exponential(exp)
      ]
    end

    def denominator
      squared_root(
        product(2, PI, variance),
      )
    end

    def exp
      negative(
        division(
          power(group(
            sum(x, negative(median))
          ), 2),
          product(2, variance)
        )
      )
    end

    def variance
      @variance ||= power(variance_root, 2)
    end
  end
end

