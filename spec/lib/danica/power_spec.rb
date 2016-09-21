require 'spec_helper'

describe Danica::Power do
  let(:subject) do
    described_class.new(*variables)
  end

  it_behaves_like 'a operator that has two terms', :power, {
    values: [ 3, 2 ],
    calculated: 9.0,
    to_tex: {
      string_expected: 'X1^{X2}',
      numeric_string_expected: '9',
      partial_string_expected: '3^{X2}'
    },
    to_gnu: {
      string_expected: 'X1**X2',
      numeric_string_expected: '9',
      partial_string_expected: '3**X2'
    }
  }
end

