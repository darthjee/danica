module Danica
  class Wrapper::Negative
    include Common
    include BaseOperations
    include VariablesHolder

    attr_accessor :value

    default_value :priority, 2
    default_value :is_grouped?, false
    
    delegate :valued?, to: :value

    def initialize(value)
      @value = wrap_value(value)
    end

    def to_f
      -value.to_f
    end

    def to_tex
      "-#{wrap_as_group(value).to_tex}"
    end

    def to_gnu
      "-#{wrap_as_group(value).to_gnu}"
    end

    def ==(other)
      return false unless other.class == self.class
      value == other.value
    end
  end
end

