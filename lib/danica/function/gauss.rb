module Danica
  class Function::Gauss < Function.build(:x, average: { latex: '\mu', gnu: :u }, variance_root: { latex: '\sigma', gnu: :v }) { num(1) / denominator * exponential(exp) }

    private

    def denominator
      variance_root * squared_root(num(2) * PI)
    end

    def exp
      - (
          ((x - average) ** 2) /
          (num(2) * variance)
      )
    end

    def variance
      @variance ||= variance_root ** 2
    end
  end
end

