# frozen_string_literal: true

require 'spec_helper'

describe Danica::Wrapper::Group do
  subject(:group) { described_class.new(value) }

  let(:value) { 10 }

  it_behaves_like 'an object that respond to basic_methods'
  it_behaves_like 'an object with basic operation'

  describe '#to_f' do
    it 'returns the float of value' do
      expect(group.to_f).to eq(10)
    end

    it { expect(group.to_f).to be_a(Float) }
  end

  describe '#to_tex' do
    context 'when value should be integer' do
      let(:value) { 10.0 }

      it 'returns the positive negative string' do
        expect(group.to_tex).to eq('\left(10\right)')
      end
    end

    context 'when value should be float' do
      let(:value) { 10.5 }

      it 'returns the positive negative string' do
        expect(group.to_tex).to eq('\left(10.5\right)')
      end
    end
  end

  describe '#to_gnu' do
    context 'when value should be integer' do
      let(:value) { 10.0 }

      it 'returns the value integer string' do
        expect(group.to_gnu).to eq('(10)')
      end
    end

    context 'when value should be a float' do
      let(:value) { 10.5 }

      it 'returns the value float string' do
        expect(group.to_gnu).to eq('(10.5)')
      end
    end
  end
end
