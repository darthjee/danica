module Danica
  class Function::Gauss < Function
    variables :x, median: :u, variance_root: :v
    delegate :to_f, :to_tex, :to_gnu, to: :product

    private

    def product
      @sum ||= Product.new(parcels)
    end

    def parcels
      [
        Division.new(1, denominator),
        Exponential.new(exponential)
      ]
    end

    def denominator
      SquaredRoot.new(
        Product.new(2, PI, variance),
      )
    end

    def exponential
      Negative.new(
        Division.new(
          Power.new(Group.new(
            Sum.new(x, Negative.new(median))
          ), 2),
          Product.new(2, variance)
        )
      )
    end

    def variance
      @variance ||= Power.new(variance_root, 2)
    end
  end
end

