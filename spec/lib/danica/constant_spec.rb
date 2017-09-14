require 'spec_helper'

describe Danica::Constant do
  subject { described_class.new(2.5, :M, :m) }
  let(:other) { described_class.new(3, :N, :n) }

  it_behaves_like 'an object that respond to basic_methods'
  it_behaves_like 'an object with basic operation'

  describe '#to_f' do
    it 'has a value' do
      expect(subject.to_f).to eq(2.5)
    end
  end

  describe '#to_tex' do
    it 'has a string for latex' do
      expect(subject.to_tex).to eq('M')
    end
  end

  describe '#to_gnu' do
    it 'has a string for gnu' do
      expect(subject.to_gnu).to eq('m')
    end
  end

  describe 'variables' do
    it { expect(subject).not_to respond_to(:value=) }
    it { expect(subject).not_to respond_to(:latex=) }
    it { expect(subject).not_to respond_to(:gnu=) }
  end

  describe '==' do
    context 'when comparing with the same object' do
      it { expect(subject).to eq(subject) }
    end

    context 'when comparing with a diferent object' do
      context 'with diferent values' do
        it { expect(subject).not_to eq(other) }
      end

      context 'with same values' do
        let(:other) { described_class.new(2.5, :M, :m) }
        it { expect(subject).to eq(other) }
      end
    end
  end
end

