require 'spec_helper'

describe Danica::Function::Division do
  let(:subject) do
    described_class.new(numerator: variables[0], denominator: variables[1])
  end

  it_behaves_like 'a function that has two terms', :division, {
    values: [ 2, 4 ],
    calculated: 1.0 / 2.0,
    string_expected: '\frac{X1}{X2}',
    numeric_string_expected: '0.5',
    partial_string_expected: '\frac{2}{X2}'
  }
end

