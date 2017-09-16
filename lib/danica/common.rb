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
      return Number.new(value) if value.is_a?(Numeric)
      return Variable.new(value) if value.is_a?(Hash)
      return Variable.new(name: value) if [ String, Symbol ].any? { |c| value.is_a?(c) }
      return Variable.new if value.nil?
      value
    end
  end
end
