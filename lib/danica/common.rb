module Danica
  module Common extend ::ActiveSupport::Concern
    included do
      include Wrapper
      include DSL

      class << self
        def default_value(name, value)
          define_method(name) { |*_| value }
        end

        def default_values(*names, value)
          names.each do |name|
            default_value(name, value)
          end
        end
      end

      default_values :constant?, :signaled?, :container?, :variable?,
                     :variable_holder?, false
    end

    def to_f
      raise Exception::NotImplemented
    end

    def to_tex(decimals: nil)
      to(:tex, decimals: decimals)
    end

    def to_gnu(decimals: nil)
      to(:gnu, decimals: decimals)
    end

    def to(format, decimals: nil)
      case format.to_sym
      when :tex
        to_tex(decimals: decimals)
      when :gnu
        to_gnu(decimals: decimals)
      when :f
        to_f
      else
        raise Exception::FormattedNotFound.new
      end
    end

    def tex
      Formatted.new(self, :tex)
    end

    def gnu
      Formatted.new(self, :gnu)
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
