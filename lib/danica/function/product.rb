module Danica
  class Function
    class Product < Function
      def to_f
        variables.map(&:to_f).inject(1) do |a,b|
          a * b
        end.to_f
      end
    end
  end
end
