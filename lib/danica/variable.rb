module Danica
  class Variable
    include ActiveModel::Model
    include BaseOperations
    include Common

    attr_accessor :value, :name, :latex, :gnu

    default_value :priority, 10
    default_value :is_grouped?, false

    def to_f
      value.nil? ? raise(Exception::NotDefined) : value.to_f
    end

    def ==(other)
      return false unless other.class == Variable
      return other.value == value &&
             other.name == name &&
             other.latex == latex &&
             other.gnu == gnu
    end

    def to_tex
      return value.to_tex if value
      (latex || name).to_s
    end

    def to_gnu
      return value.to_gnu if value
      (gnu || name).to_s
    end

    def value=(value)
      @value = value.is_a?(Numeric) ? number(value) : value
    end
  end
end

