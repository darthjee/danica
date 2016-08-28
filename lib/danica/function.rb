class Danica::Function
  include ActiveModel::Model

  require 'danica/function/chained'
  require 'danica/function/product'
  require 'danica/function/sum'
  require 'danica/function/division'

  attr_accessor :name, :variables

  def to_f
    raise 'Not IMplemented yet'
  end

  def to_tex
    raise 'Not IMplemented yet'
  end

  def variables=(variables)
    @variables = variables.map { |v| wrap_value(v) }
  end

  def valued?
    to_f.presend?
  rescue Danica::NotDefined
    false
  end

  private

  def wrap_value(value)
    value.is_a?(Numeric) ? Danica::Number.new(value) : value
  end
end
