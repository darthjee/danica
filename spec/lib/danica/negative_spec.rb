require 'spec_helper'

describe Danica::Negative do
  let(:value) { Danica::Number.new(10) }
  subject { described_class.new(value) }

  it_behaves_like 'an object that respond to basic_methods'
  it_behaves_like 'an object with basic operation'

  describe '#to_f' do
    it 'returns the float of value' do
      expect(subject.to_f).to eq(-10)
    end

    it { expect(subject.to_f).to be_a(Float) }
  end

  describe '#to_tex' do
    context 'when value should be integer' do
      let(:value) { 10.0 }

      it 'returns the value integer string' do
        expect(subject.to_tex).to eq('-10')
      end
    end

    context 'when value should be float' do
      let(:value) { 10.5 }

      it 'returns the value float string' do
        expect(subject.to_tex).to eq('-10.5')
      end
    end
  end

  describe '#to_gnu' do
    context 'when value should be integer' do
      let(:value) { 10.0 }

      it 'returns the value integer string' do
        expect(subject.to_gnu).to eq('-10')
      end
    end

    context 'when value should be a float' do
      let(:value) { 10.5 }

      it 'returns the value float string' do
        expect(subject.to_gnu).to eq('-10.5')
      end
    end
  end
end
