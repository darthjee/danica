# frozen_string_literal: true

require 'spec_helper'

describe Danica::Operator::Multiplication do
  describe 'of number and addition' do
    subject do
      described_class.new(
        3, Danica::Operator::Addition.new(2, 4)
      )
    end

    describe '#to_gnu' do
      it 'returns the correct string' do
        expect(subject.to_gnu).to eq('3 * (2 + 4)')
      end
    end

    describe '#to_gnu' do
      it 'returns the correct string' do
        expect(subject.to_tex).to eq('3 \cdot \left(2 + 4\right)')
      end
    end
  end

  describe 'of additions' do
    subject do
      described_class.new(
        Danica::Operator::Addition.new(1, 2),
        Danica::Operator::Addition.new(3, 4)
      )
    end

    describe '#to_gnu' do
      it 'returns the correct string' do
        expect(subject.to_gnu).to eq('(1 + 2) * (3 + 4)')
      end
    end

    describe '#to_tex' do
      it 'returns the correct string' do
        expect(subject.to_tex).to eq('\left(1 + 2\right) \cdot \left(3 + 4\right)')
      end
    end
  end

  describe 'when calling * operator' do
    subject do
      described_class.new(:x, :y)
    end

    let(:variable) { Danica::Wrapper::Variable.new(:v) }
    let(:result) { subject * variable }

    it do
      expect(result).to be_a(described_class)
    end

    it 'knows how to order variables' do
      expect(result.to_gnu).to eq('x * y * v')
    end

    context 'when called from the other' do
      let(:result) { variable * subject }

      it do
        expect(result).to be_a(described_class)
      end

      it 'knows how to order variables' do
        expect(result.to_gnu).to eq('v * x * y')
      end
    end
  end

  context 'when multiplicating a negative number' do
    let(:x) { Danica::Wrapper::Variable.new(:x) }
    let(:y) { Danica::Wrapper::Variable.new(:y) }
    let(:negative) { -y }
    let(:result) { x * negative }

    it do
      expect(result).to be_a(described_class)
    end

    it 'knows how to order variables' do
      expect(result.to_gnu).to eq('x * (-y)')
    end

    context 'when negative parcel is an expression' do
      let(:negative) { Danica.build(:y) { -y } }

      it 'knows how to order variables' do
        expect(result.to_gnu).to eq('x * (-y)')
      end
    end

    context 'when negative is the negative of an expression' do
      let(:negative) { -Danica.build(:y) { y } }

      it 'knows how to order variables' do
        expect(result.to_gnu).to eq('x * (-y)')
      end
    end
  end
end
