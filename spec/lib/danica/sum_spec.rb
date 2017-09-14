require 'spec_helper'

describe Danica::Sum do
  subject { described_class.new(10, 2) }

  it_behaves_like 'an object that respond to basic_methods'

  it_behaves_like 'an object with basic operation', operations: %i(* /)
  it_behaves_like 'an object with + operation' do
    let(:subject_included) { 10 }

    context 'when other is also a sum' do
      let(:other) { described_class.new(200, 5) }

      it 'includes the sum parcels' do
        expect(result).to include(200)
      end
    end
  end
  it_behaves_like 'an object with - operation' do
    let(:subject_included) { 10 }
  end

  it_behaves_like 'a operator that joins many variables with same operation', {
    calculated: 10,
    numeric_variables: [ 1.5, 2.5, 3.5 ],
    to_tex: {
      string_expected: 'X1 + X2 + X3 + X4',
      integer_expected: '4 + X3 + X4',
      float_expected: '7.5 + X4'
    },
    to_gnu: {
      string_expected: 'X1 + X2 + X3 + X4',
      integer_expected: '4 + X3 + X4',
      float_expected: '7.5 + X4'
    }
  }
end
