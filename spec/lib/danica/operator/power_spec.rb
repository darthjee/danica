require 'spec_helper'

describe Danica::Operator::Power do
  let(:variables) { [2, 4] }
  subject { described_class.new(*variables) }

  it_behaves_like 'an object that respond to basic_methods'
  it_behaves_like 'an object with basic operation'

  it_behaves_like 'a operator that has two terms', :power, {
    values: [ 3, 2 ],
    calculated: 9.0,
    to_tex: {
      string_expected: 'X1^{X2}',
      numeric_string_expected: '3^{2}',
      partial_string_expected: '3^{X2}'
    },
    to_gnu: {
      string_expected: 'X1**(X2)',
      numeric_string_expected: '3**(2)',
      partial_string_expected: '3**(X2)'
    }
  }
end
