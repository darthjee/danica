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

    def to_tex(**options)
      to(:tex, **options)
    end

    def to_gnu(**options)
      to(:gnu, **options)
    end

    def to(format, **options)
      case format.to_sym
      when :tex
        to_tex(**options)
      when :gnu
        to_gnu(**options)
      when :f
        to_f
      else
        raise Exception::FormattedNotFound
      end
    end

    def tex(**options)
      formatted(format: :tex, **options)
    end

    def gnu(**options)
      formatted(format: :gnu, **options)
    end

    def formatted(**options)
      Formatted.new(self, **options)
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
