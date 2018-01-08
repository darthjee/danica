module Danica
  class Equation
    include VariablesHolder
  
    autoload :Builder, 'danica/equation/builder'

    class << self
      def build(*variables, &block)
        Builder.new(*variables, &block).build
      end

      def create(*variables, &block)
        build(*variables, &block).new
      end
    end

    def to(format)
      "#{left.to(format)} = #{right.to(format)}"
    end
  end
end


