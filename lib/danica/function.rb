class Danica::Function
  include ActiveModel::Model

  require 'danica/function/product'
  require 'danica/function/sum'
  require 'danica/function/division'

  attr_accessor :name, :variables

  def variables=(variables)
    @variables = variables.map { |v| wrap_value(v) }
  end

  private

  def wrap_value(value)
    value.is_a?(Numeric) ? Danica::Number.new(value) : value
  end
end
