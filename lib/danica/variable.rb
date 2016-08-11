module Danica
  class Variable
    include ActiveModel::Model
    attr_accessor :value, :name, :latex

    def calculate
      value.nil? ? raise('errror') : value
    end
  end
end

