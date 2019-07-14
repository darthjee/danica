# frozen_string_literal: true

module Danica
  class Expression::Gauss < Expression.build(:x, average: { latex: '\mu', gnuplot: :u }, variance_root: { latex: '\sigma', gnuplot: :v }) { num(1) / denominator * exponential(exp) }
    private

    def denominator
      variance_root * sqrt(num(2) * PI)
    end

    def exp
      - (
          ((x - average)**2) /
          (num(2) * variance)
        )
    end

    def variance
      @variance ||= variance_root**2
    end
  end
end
