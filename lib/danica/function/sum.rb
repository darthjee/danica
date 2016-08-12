module Danica
  class Function
    class Sum < Function
      def calculate
        variables.map(&:calculate).inject(0) do |a,b|
          a + b
        end
      end
    end
  end
end

