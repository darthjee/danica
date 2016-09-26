require 'spec_helper'

describe Danica::Constant do
  let(:subject) { described_class.new(2.5, :M, :m) }

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
end

