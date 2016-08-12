module Danica
  class Function
    class Product < Function
      def calculate
        variables.map(&:calculate).inject(1) do |a,b|
          a * b
        end
      end
    end
  end
end
