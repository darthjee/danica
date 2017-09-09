require 'spec_helper'

describe Danica::Sin do
  subject { described_class.new(10) }

  it_behaves_like 'an object with + operation'

  it_behaves_like 'a operator with a single input value', {
    variable_value: Math::PI / 2.0,
    expected_number: 1.0,
    expected_number_text: '1',
    expected_tex: 'sin(X)',
    expected_gnu: 'sin(X)'
  }
end
