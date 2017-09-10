require 'spec_helper'

describe Danica::Division do
  let(:variables) { [2, 4] }
  subject { described_class.new(*variables) }

  it_behaves_like 'an object with basic operation'

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

