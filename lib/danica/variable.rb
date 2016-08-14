module Danica
  class Variable
    include ActiveModel::Model
    attr_accessor :value, :name, :latex

    def to_f
      value.nil? ? raise(NotDefined) : value
    end

    def to_tex
      (latex || name).to_s
    end
  end
end

