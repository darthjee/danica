module Danica
  class Negative
    include Common
    include BaseOperations
    include VariablesHolder
    include ActiveModel::Model

    attr_accessor :value

    default_value :priority, 1
    default_value :is_grouped?, false
    
    delegate :valued?, to: :value

    def initialize(value)
      @value = wrap_value(value)
    end

    def to_f
      -value.to_f
    end

    def to_tex
      "-#{value.to_tex}"
    end

    def to_gnu
      "-#{value.to_gnu}"
    end

    def ==(other)
      return false unless other.class == self.class
      value == other.value
    end
  end
end

