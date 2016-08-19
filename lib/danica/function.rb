class Danica::Function
  include ActiveModel::Model

  require 'danica/function/product'
  require 'danica/function/sum'
  require 'danica/function/division'

  attr_accessor :name, :variables

  private

  def wrap_value(value)
    value.is_a?(Fixnum) ? Number.new(value) : value 
  end
end
