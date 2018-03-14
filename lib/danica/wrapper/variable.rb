module Danica
  class Wrapper::Variable
    include BaseOperations
    include Common

    attr_accessor :value, :name, :latex, :gnuplot

    default_value :priority,    10
    default_value :is_grouped?, false
    default_value :variable?,   true

    def initialize(*args)
      attrs = args.extract_options!
      attrs = args.as_hash(%i(name value latex gnuplot)).merge(attrs)

      attrs.each do |key, value|
        self.public_send("#{key}=", value)
      end
    end

    def to_f
      value.nil? ? raise(Exception::NotDefined) : value.to_f
    end

    def ==(other)
      return false unless other.class == self.class
      return other.value == value &&
             other.name == name &&
             other.latex == latex &&
             other.gnuplot == gnuplot
    end

    def to_tex
      return value.to_tex if value
      (latex || name).to_s
    end

    def to_gnu
      return value.to_gnu if value
      (gnuplot || name).to_s
    end

    def value=(value)
      @value = value.is_a?(Numeric) ? number(value) : value
    end
  end
end

