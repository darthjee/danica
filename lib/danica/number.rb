module Danica
  class Number
    include ActiveModel::Model
    include BaseOperations

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

    def ==(other)
      return false unless other.class == self.class
      value == other.value
    end

    def priority
      10
    end

    alias_method :to_gnu, :to_tex
  end
end

