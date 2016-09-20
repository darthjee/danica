require 'spec_helper'

describe Danica::Function::Exponential do
  it_behaves_like 'a function with a single input value', {
    variable_value: 2,
    expected_number: Math.exp(2),
    expected_number_text: Math.exp(2).to_s,
    expected_tex: 'e^{X}',
    expected_gnu: 'exp(X)'
  }
end