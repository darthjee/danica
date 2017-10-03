require 'spec_helper'

describe Danica::Operator::Cos do
  subject { described_class.new(:x) }

  it_behaves_like 'an object that respond to basic_methods'
  it_behaves_like 'an object with basic operation'

  it_behaves_like 'a operator with a single input value', {
    variable_value: Math::PI,
    expected_number: -1.0,
    expected_number_tex: 'cos(3.141592653589793)',
    expected_number_gnu: 'cos(3.141592653589793)',
    expected_tex: 'cos(X)',
    expected_gnu: 'cos(X)'
  }
end
