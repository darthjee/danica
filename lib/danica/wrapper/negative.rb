# frozen_string_literal: true

module Danica
  class Wrapper::Negative
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
      -value.to_f
    end

    def to(format, **)
      "-#{wrap_as_group(value).to(format, **)}"
    end

    def ==(other)
      return false unless other.class == self.class

      value == other.value
    end
  end
end
