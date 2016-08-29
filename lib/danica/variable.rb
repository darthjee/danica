module Danica
  class Variable
    include ActiveModel::Model
    attr_accessor :value, :name, :latex, :gnu

    def to_f
      value.nil? ? raise(Exception::NotDefined) : value.to_f
    end

    def to_tex
      (value || latex || name).to_s
    end

    def to_gnu
      (value || gnu || name).to_s
    end

    def valued?
      value.present?
    end
  end
end

