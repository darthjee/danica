require 'spec_helper'

describe Danica::Operator::Division do
  let(:subject) do
    described_class.new(*variables)
  end

  it_behaves_like 'a operator that has two terms', :division, {
    values: [ 2, 4 ],
    calculated: 1.0 / 2.0,
    to_tex: {
      string_expected: '\frac{X1}{X2}',
      numeric_string_expected: '0.5',
      partial_string_expected: '\frac{2}{X2}'
    },
    to_gnu: {
      string_expected: 'X1/X2',
      numeric_string_expected: '0.5',
      partial_string_expected: '2/X2'
    }
  }
end

