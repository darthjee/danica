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
