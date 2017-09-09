module Danica
  class Constant
    include BaseOperations

    attr_reader :value, :latex, :gnu

    def initialize(value, latex, gnu)
      @value = value
      @latex = latex
      @gnu = gnu
    end

    def to_f
      value.to_f
    end

    def ==(other)
      return false unless other.class == self.class
      gnu == other.gnu && latex == other.latex && value == other.value
    end

    def to_tex
      latex.to_s
    end

    def to_gnu
      gnu.to_s
    end

    def valued?
      true
    end
  end

  E = Constant.new(Math::E, :e, 'exp(1)')
  PI =  Constant.new(Math::PI, '\pi', :pi)
end

