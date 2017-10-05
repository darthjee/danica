module Danica
  module Common extend ::ActiveSupport::Concern
    included do
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
  
    def valued?
      to_f.present?
    rescue Exception::NotDefined
      false
    end
  
    private

    def wrap_value(value)
      return wrap_value(number(value)) if value.is_a?(Numeric)
      return wrap_value(variable(value)) if value.is_a?(Hash)
      return wrap_value(variable(name: value)) if [ String, Symbol ].any? { |c| value.is_a?(c) }
      return wrap_value(variable) if value.nil?
      value
    end

    def wrap_as_group(value)
      return value if is_grouped? || value.priority >= priority
      group(value)
    end
  end
end
