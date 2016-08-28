module Danica
  class Number
    include ActiveModel::Model

    attr_accessor :value

    delegate :to_f, to: :value

    def initialize(value)
      @value = value
    end

    def to_tex
      return value.to_i.to_s if value.to_i == value
      value.to_s
    end

    def valued?
      value.present?
    end
  end
end


