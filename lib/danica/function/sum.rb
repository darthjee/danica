module Danica
  class Function
    class Sum < Function
      def to_f
        variables.map(&:to_f).inject(0) do |a,b|
          a + b
        end.to_f
      end
    end
  end
end

