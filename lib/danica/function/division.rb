module Danica
  class Function
    class Division < Function
      def to_f
        variables.map(&:to_f).inject(1.0) do |a,b|
          a / b.to_f
        end
      end
    end
  end
end

