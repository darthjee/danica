require 'spec_helper'

describe Danica::Variable do
  describe :calculate do
    context 'when variable has no value' do
      it { expect { subject.calculate }.to raise_error(Danica::NotDefined) }
    end

    context 'when variable has value' do
      let(:value) { 100 }
      let(:subject) { described_class.new(value: value) }

      it { expect(subject.calculate).to eq(value) }
    end
  end
end
