require 'spec_helper'

describe Danica::Exponential do
  subject { described_class.new(2) }

  it_behaves_like 'an object that respond to basic_methods'
  it_behaves_like 'an object with basic operation'

  it_behaves_like 'a operator with a single input value', {
    variable_value: 2,
    expected_number: Math.exp(2),
    expected_number_text: Math.exp(2).to_s,
    expected_tex: 'e^{X}',
    expected_gnu: 'exp(X)'
  }
end
