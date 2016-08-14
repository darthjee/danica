require 'spec_helper'

describe Danica::Function::Sum do
  it_behaves_like 'a function that joins many variables with same operation', {
    calculated: 10,
    symbol: '+'
  }
end
