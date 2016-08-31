require 'spec_helper'

describe Danica::Function::Power do
  let(:values) { [ 3, 2 ] }
  let(:variables) do
    [ 1, 2 ].map do |i|
      { name: "X#{i}", value: values[i-1] }
    end
  end
  let(:subject) do
    described_class.new(base: variables[0], exponent: variables[1])
  end

  it_behaves_like 'a function that has two terms and knows how to calculate it', :division, {
    values: [ 3, 2 ],
    calculated: 9.0
  }
  it_behaves_like 'a function that has two terms and knows how to call to_tex', {
    values: [3, 2],
    string_expected: 'X1^{X2}',
    numeric_string_expected: '9',
    partial_string_expected: '3^{X2}'
  }
end

