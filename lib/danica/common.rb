module Danica
  module Common extend ::ActiveSupport::Concern
    included do
      include Wrapper
      include DSL

      class << self
        def default_value(name, value)
          define_method(name) { |*_| value }
        end
      end

      default_value :constant?,  false
      default_value :signaled?,  false
      default_value :container?, false
      default_value :variable?,  false
    end

    def to_f
      raise Exception::NotImplemented
    end

    def to_tex
      to(:tex)
    end

    def to_gnu
      to(:gnu)
    end

    def to(format)
      case format.to_sym
      when :tex
        to_tex
      when :gnu
        to_gnu
      else
        raise Exception::FormatNotFound.new
      end
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
