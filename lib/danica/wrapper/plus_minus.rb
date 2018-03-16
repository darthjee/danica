module Danica
  class Wrapper::PlusMinus
    include BaseOperations
    include VariablesHolder

    attr_accessor :value

    default_value :priority, 2
    default_value :is_grouped?, false
    default_value :signaled?, true

    delegate :valued?, to: :value

    def initialize(value)
      @value = wrap_value(value)
    end

    def to_f
      value.to_f
    end

    def to_tex(**options)
      "\\pm #{wrap_as_group(value).to_tex(options)}"
    end

    def to_gnu(**options)
      "+ #{wrap_as_group(value).to_gnu(options)}"
    end

    def ==(other)
      return false unless other.class == self.class
      value == other.value
    end
  end
end

