class Danica::Function
  include ActiveModel::Model

  require 'danica/function/product'
  require 'danica/function/sum'
  require 'danica/function/division'

  attr_accessor :name, :variables
end
