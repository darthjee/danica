# frozen_string_literal: true

module Danica
  class Wrapper::Number
    include BaseOperations
    include Common

    attr_accessor :value

    default_value :priority, 10
    delegate :to_f, to: :value
    default_value :is_grouped?, false

    def initialize(value)
      @value = value
    end

    def to(_format, decimals: nil, **_options)
      return value.to_i.to_s if value.to_i == value
      return format("%.#{decimals}f", value).to_f.to_s if decimals

      value.to_s
    end

    def valued?
      value.present?
    end

    def signaled?
      value < 0
    end

    def ==(other)
      return false unless other.class == self.class

      value == other.value
    end
  end
end
