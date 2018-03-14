require 'spec_helper'

describe Danica::Format do
  let(:content) { Danica::Wrapper::Variable.new(latex: :V, gnu: :v) }
  let(:format) { :tex }
  subject do
    described_class.new(content, format)
  end

  describe '#to_s' do
    it 'return the expected format from the object' do
      expect(subject.to_s).to eq('V')
    end
  end

  describe 'operators' do
    describe '+' do
      it do
        expect(subject + 2).to be_a(described_class)
      end

      it 'keeps being able to parse format' do
        expect((subject + 2).to_s).to eq('V + 2')
      end
    end

    describe '*' do
      it do
        expect(subject * 2).to be_a(described_class)
      end

      it 'keeps being able to parse format' do
        expect((subject * 2).to_s).to eq('V \cdot 2')
      end
    end
  end
end
