module Danica
  class Group
    include Common
    include ActiveModel::Model

    attr_accessor :value

    default_value :priority, 10
    
    delegate :to_f, :valued?, to: :value

    def initialize(value)
      @value = wrap_value(value)
    end

    def to_tex
      "\\left(#{value.to_tex}\\right)"
    end

    def to_gnu
      "(#{value.to_gnu})"
    end
  end
end


