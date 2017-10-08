module Danica
  class Function::Gauss < Function.build(:x, median: :u, variance_root: { latex: '\theta', gnu: :v }) { multiplication(parcels) }

    private

    def parcels
      [
        division(1, denominator),
        exponential(exp)
      ]
    end

    def denominator
      squared_root(
        multiplication(2, PI, variance),
      )
    end

    def exp
      negative(
        division(
          power(group(
            addition(x, negative(median))
          ), 2),
          multiplication(2, variance)
        )
      )
    end

    def variance
      @variance ||= power(variance_root, 2)
    end
  end
end

