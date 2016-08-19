module Danica
  class Number
    include ActiveModel::Model

    attr_accessor :value

    delegate :to_f, to: :value

    def initialize(value)
      @value = value
    end

    def to_tex
      value
    end
  end
end


