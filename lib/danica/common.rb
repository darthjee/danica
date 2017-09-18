module Danica
  module Common extend ::ActiveSupport::Concern
    included do
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
      return wrap_value(Number.new(value)) if value.is_a?(Numeric)
      return wrap_value(Variable.new(value)) if value.is_a?(Hash)
      return wrap_value(Variable.new(name: value)) if [ String, Symbol ].any? { |c| value.is_a?(c) }
      return wrap_value(Variable.new) if value.nil?
      return Group.new(value) if wrap_as_group?(value)
      value
    end

    def wrap_as_group?(value)
      value.priority < priority unless is_grouped?
    end
  end
end
