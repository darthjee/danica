require 'spec_helper'

describe Danica::Cos do
  it_behaves_like 'a operator with a single input value', {
    variable_value: Math::PI,
    expected_number: -1.0,
    expected_number_text: '-1',
    expected_tex: 'cos(X)',
    expected_gnu: 'cos(X)'
  }
end
