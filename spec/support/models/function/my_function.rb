# frozen_string_literal: true

class Danica::Function::MyFunction < Danica::Function
  variables :x, :y

  def function_block
    x**2 + y
  end
end
