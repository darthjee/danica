require 'spec_helper'

describe Danica::Function::Product do
  it_behaves_like 'a function that joins many variables with same operation', {
    calculated: 24,
    numeric_variables: [ 1.5, 2, 3.5 ],
    to_tex: { 
      string_expected: %w(X1 X2 X3 X4).join(' \cdot '),
      integer_expected: %w(3 X3 X4).join(' \cdot '),
      float_expected: '10.5 \cdot X4'
    }
  }
end
