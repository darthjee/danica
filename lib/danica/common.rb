module Danica
  module Common extend ::ActiveSupport::Concern
    included do
      include Wrapper
      include DSL

      class << self
        def default_value(name, value)
          define_method(name) { value }
        end
      end
    end

    def to_f
      raise 'Not IMplemented yet'
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
  
    private

    def wrap_as_group(value)
      return value if is_grouped? || value.priority >= priority
      group(value)
    end
  end
end
