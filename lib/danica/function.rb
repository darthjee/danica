class Danica::Function
  include ActiveModel::Model

  require 'danica/function/product'
  require 'danica/function/sum'

  attr_accessor :name, :variables
end
