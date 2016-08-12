class Danica::Function
  include ActiveModel::Model

  require 'danica/function/product'

  attr_accessor :name, :variables
end
