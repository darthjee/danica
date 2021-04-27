# frozen_string_literal: true

module Danica
  class Wrapper::Group
    include Common
    include BaseOperations

    attr_accessor :value

    default_value :priority, 10
    default_value :is_grouped?, true

    delegate :to_f, :valued?, to: :value

    def initialize(value)
      @value = wrap_value(value)
    end

    def to_tex(**options)
      "\\left(#{value.to_tex(options)}\\right)"
    end

    def to_gnu(**options)
      "(#{value.to_gnu(options)})"
    end

    def ==(other)
      return value == other unless other.is_a?(self.class)

      value == other.value
    end
  end
end
