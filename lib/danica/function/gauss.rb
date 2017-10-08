module Danica
  class Function::Gauss < Function.build(:x, average: { latex: '\mu', gnu: :u }, variance_root: { latex: '\sigma', gnu: :v }) { multiplication(elements) }

    private

    def elements
      [
        division(1, denominator),
        exponential(exp)
      ]
    end

    def denominator
      variance_root *
      squared_root(
        multiplication(2, PI),
      )
    end

    def exp
      negative(
        division(
          power(group(
            addition(x, negative(average))
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

