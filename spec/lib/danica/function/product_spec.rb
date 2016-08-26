require 'spec_helper'

describe Danica::Function::Product do
  it_behaves_like 'a function that joins many variables with same operation', {
    calculated: 24,
    tex_expected: %w(X1 X2 X3 X4).join('\cdot'),
    tex_integer_expected: %w(3 X3 X4).join('\cdot'),
    tex_float_expected: '10.5\cdotX4',
    numeric_variables: [ 1.5, 2, 3.5 ]
  }
end
