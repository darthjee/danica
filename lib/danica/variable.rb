module Danica
  class Variable
    include ActiveModel::Model
    attr_accessor :value, :name, :latex, :gnu

    def to_f
      value.nil? ? raise(Exception::NotDefined) : value.to_f
    end

    def to_tex
      return value.to_tex if value
      (latex || name).to_s
    end

    def to_gnu
      return value.to_gnu if value
      (gnu || name).to_s
    end

    def valued?
      value.present?
    end

    def value=(value)
      @value = value.is_a?(Numeric) ? Number.new(value) : value
    end
  end
end

