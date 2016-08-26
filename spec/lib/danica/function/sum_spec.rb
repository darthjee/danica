require 'spec_helper'

describe Danica::Function::Sum do
  it_behaves_like 'a function that joins many variables with same operation', {
    calculated: 10,
    tex_expected: 'X1+X2+X3+X4',
    tex_integer_expected: '4+X3+X4',
    tex_float_expected: '7.5+X4',
    numeric_variables: [ 1.5, 2.5, 3.5 ]
  }
end
