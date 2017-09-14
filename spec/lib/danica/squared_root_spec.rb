require 'spec_helper'

describe Danica::SquaredRoot do
  subject { described_class.new(9) }

  it_behaves_like 'an object that respond to basic_methods'
  it_behaves_like 'an object with basic operation'

  it_behaves_like 'a operator with a single input value', {
    variable_value: 9,
    expected_number: 3.0,
    expected_number_text: '3',
    expected_tex: '\sqrt{X}',
    expected_gnu: 'sqrt(X)'
  }
end
