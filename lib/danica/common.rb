# frozen_string_literal: true

module Danica
  module Common
    extend ::ActiveSupport::Concern
    included do
      include Wrapper
      include DSL

      default_values :constant?, :signaled?, :container?, :variable?,
                     :variable_holder?, false
      default_value  :priority, 1
    end

    class_methods do
      def default_value(name, value)
        define_method(name) { |*_| value }
      end

      def default_values(*names, value)
        names.each do |name|
          default_value(name, value)
        end
      end
    end

    def to_f
      raise Exception::NotImplemented
    end

    def to_tex(**)
      to(:tex, **)
    end

    def to_gnu(**)
      to(:gnu, **)
    end

    def to(format, **)
      case format.to_sym
      when :tex
        to_tex(**)
      when :gnu
        to_gnu(**)
      when :f
        to_f
      else
        raise Exception::FormattedNotFound
      end
    end

    def tex(**)
      formatted(format: :tex, **)
    end

    def gnu(**)
      formatted(format: :gnu, **)
    end

    def formatted(**)
      Formatted.new(self, **)
    end

    def valued?
      to_f.present?
    rescue Exception::NotDefined
      false
    end

    def content
      self
    end

    private

    def wrap_as_group(value)
      return value if is_grouped? || value.priority >= priority

      group(value)
    end
  end
end
