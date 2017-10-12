module Danica
  class Wrapper::Constant
    include BaseOperations
    include Common

    attr_reader :value, :latex, :gnu

    default_value :priority, 10
    default_value :valued?, true
    default_value :is_grouped?, false

    def initialize(*args)
      attrs = args.extract_options!
      attrs = args.as_hash(%i(value latex gnu)).merge(attrs)

      attrs.each do |key, value|
        self.send("#{key}=", value)
      end
    end

    def to_f
      value.to_f
    end

    def ==(other)
      return false unless other.class == self.class
      gnu == other.gnu && latex == other.latex && value == other.value
    end

    def to(format)
      case format.to_sym
      when :tex
        latex.to_s
      when :gnu
        gnu.to_s
      else
        raise Exception::FormatNotFound.new
      end
    end

    def to_tex
      to(:tex)
    end

    def to_gnu
      to(:gnu)
    end

    private

    def value=(value)
      @value = value
    end

    def latex=(latex)
      @latex = latex
    end

    def gnu=(gnu)
      @gnu = gnu
    end
  end

  E = Wrapper::Constant.new(Math::E, :e, 'exp(1)')
  PI = Wrapper::Constant.new(Math::PI, '\pi', :pi)
end

