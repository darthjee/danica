require 'spec_helper'

describe Danica::Operator::Multiplication do
  subject { described_class.new(2,4) }

  it 'initializes from array' do
    expect do
      described_class.new(10, 2)
    end.not_to raise_error
  end

  it_behaves_like 'an object that respond to basic_methods'

  it_behaves_like 'an object with * operation' do
    let(:subject_included) { 4 }

    context 'when other is also a addition' do
      let(:other) { described_class.new(200, 5) }

      it 'includes the addition parcels' do
        expect(result).to include(200)
      end
    end
  end
  it_behaves_like 'an object with basic operation', ignore: :*

  it_behaves_like 'a operator that joins many variables with same operation', {
    calculated: 24,
    numeric_variables: [ 1.5, 2, 3.5 ],
    to_tex: { 
      string_expected: %w(X1 X2 X3 X4).join(' \cdot '),
      integer_expected: %w(1.5 2 X3 X4).join(' \cdot '),
      float_expected: %w(1.5 2 3.5 X4).join(' \cdot ')
    },
    to_gnu: {
      string_expected: %w(X1 X2 X3 X4).join(' * '),
      integer_expected: %w(1.5 2 X3 X4).join(' * '),
      float_expected: %w(1.5 2 3.5 X4).join(' * '),
    }
  }
end
