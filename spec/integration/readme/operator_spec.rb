require 'spec_helper'

describe MyOperator do
  describe '#to_gnu' do
    it 'returns the gnu format' do
      expect(subject.to_gnu).to eq('x**(pi)')
    end
  end

  describe '#to_tex' do
    it 'returns the tex format' do
      expect(subject.to_tex).to eq('x^{\pi}')
    end
  end

  describe '#to_f' do
    subject { described_class.new(x: 2) }

    it 'returns the result of the operation' do
      expect(subject.to_f).to eq(2 ** Math::PI)
    end
  end
end

describe Danica::Operator::Inverse do
  subject { described_class.new(:x) }

  describe '#to_tex' do
    it 'returns the formated tex string' do
      expect(subject.to_tex).to eq('(x)^{-1}')
    end
  end

  describe '#to_gnu' do
    it 'returns the formated gnu string' do
      expect(subject.to_gnu).to eq('(x) ** -1')
    end
  end

  describe '#to_f' do
    it do
      expect { subject.to_f }.to raise_error(Danica::Exception::NotDefined)
    end

    context 'when value is defined' do
      subject { described_class.new 2 }

      it 'returns the calculated value' do
        expect(subject.to_f).to eq(0.5)
      end
    end
  end

  describe '#calculate' do
    it 'returns the calculated value' do
      expect(subject.calculate(2)).to eq(0.5)
    end
  end
end
