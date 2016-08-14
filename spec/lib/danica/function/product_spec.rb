require 'spec_helper'

describe Danica::Function::Product do
  it_behaves_like 'a function that knows how to calculate', {
    calculated: 24
  }
end
