module Danica
  class Group <  Common
    include ActiveModel::Model

    attr_accessor :value
    
    delegate :to_f, :valued?, to: :value

    def initialize(value)
      @value = wrap_value(value)
    end

    def to_tex
      "(#{value.to_tex})"
    end

    alias_method :to_gnu, :to_tex
  end
end


