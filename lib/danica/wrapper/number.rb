module Danica
  class Wrapper::Number
    include ActiveModel::Model
    include BaseOperations
    include Common

    attr_accessor :value

    default_value :priority, 10
    delegate :to_f, to: :value
    default_value :is_grouped?, false

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

    alias_method :to_gnu, :to_tex
  end
end

