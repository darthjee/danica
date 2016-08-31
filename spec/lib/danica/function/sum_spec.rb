require 'spec_helper'

describe Danica::Function::Sum do
  it_behaves_like 'a function that joins many variables with same operation', {
    calculated: 10,
    numeric_variables: [ 1.5, 2.5, 3.5 ],
    to_tex: {
      string_expected: 'X1 + X2 + X3 + X4',
      integer_expected: '4 + X3 + X4',
      float_expected: '7.5 + X4'
    }
  }
end
