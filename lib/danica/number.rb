module Danica
  class Variable
    include ActiveModel::Model

    delegate :to_f, to: :value

    def initialize(value)
      @value = value
    end
  end
end


