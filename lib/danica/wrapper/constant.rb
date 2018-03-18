module Danica
  class Wrapper::Constant
    include BaseOperations
    include Common

    attr_reader :value, :latex, :gnuplot

    default_value :priority, 10
    default_value :valued?, true
    default_value :is_grouped?, false
    default_value :constant?, true

    def initialize(*args)
      attrs = args.extract_options!
      attrs = args.as_hash(%i(value latex gnuplot)).merge(attrs)

      attrs.each do |key, value|
        self.send("#{key}=", value)
      end
    end

    def to_f
      value.to_f
    end

    def ==(other)
      return false unless other.class == self.class
      gnuplot == other.gnuplot && latex == other.latex && value == other.value
    end

    def to_tex(**_)
      latex.to_s
    end

    def to_gnu(**_)
      gnuplot.to_s
    end

    private

    def value=(value)
      @value = value
    end

    def latex=(latex)
      @latex = latex
    end

    def gnuplot=(gnuplot)
      @gnuplot = gnuplot
    end
  end

  E = Wrapper::Constant.new(Math::E, :e, 'exp(1)')
  PI = Wrapper::Constant.new(Math::PI, '\pi', :pi)
end

