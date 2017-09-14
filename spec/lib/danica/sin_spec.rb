require 'spec_helper'

describe Danica::Sin do
  subject { described_class.new(10) }

  it_behaves_like 'an object that respond to basic_methods'
  it_behaves_like 'an object with basic operation'

  it_behaves_like 'a operator with a single input value', {
    variable_value: Math::PI / 2.0,
    expected_number: 1.0,
    expected_number_tex: 'sin(1.5707963267948966)',
    expected_number_gnu: 'sin(1.5707963267948966)',
    expected_tex: 'sin(X)',
    expected_gnu: 'sin(X)'
  }
end
