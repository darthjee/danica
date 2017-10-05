module Danica
  class Wrapper::Constant
    include BaseOperations
    include Common

    attr_reader :value, :latex, :gnu

    default_value :priority, 10
    default_value :valued?, true
    default_value :is_grouped?, false

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
  end

  E = Wrapper::Constant.new(Math::E, :e, 'exp(1)')
  PI = Wrapper::Constant.new(Math::PI, '\pi', :pi)
end

