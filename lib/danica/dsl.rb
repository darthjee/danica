module Danica
  module DSL
    def sum(*args)
      Sum.new(*args)
    end

    def division(*args)
      Division.new(*args)
    end

    def product(*args)
      Product.new(*args)
    end
  end
end

