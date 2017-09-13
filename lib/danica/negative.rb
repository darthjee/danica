module Danica
  class Negative <  Common
    include ActiveModel::Model

    attr_accessor :value
    
    delegate :valued?, to: :value

    def initialize(value)
      @value = wrap_value(value)
    end

    def to_f
      -value.to_f
    end

    def to_tex
      "-#{value.to_tex}"
    end

    def to_gnu
      "-#{value.to_gnu}"
    end
  end
end

