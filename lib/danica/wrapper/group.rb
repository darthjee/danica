# frozen_string_literal: true

module Danica
  module Wrapper
    class Group
      include Common
      include BaseOperations

      attr_accessor :value

      default_value :priority, 10
      default_value :is_grouped?, true

      delegate :to_f, :valued?, to: :value

      def initialize(value)
        @value = wrap_value(value)
      end

      def to_tex(**)
        "\\left(#{value.to_tex(**)}\\right)"
      end

      def to_gnu(**)
        "(#{value.to_gnu(**)})"
      end

      def ==(other)
        return value == other unless other.is_a?(self.class)

        value == other.value
      end
    end
  end
end
