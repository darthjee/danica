# frozen_string_literal: true

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
      expect(subject.to_f).to eq(2**Math::PI)
    end
  end
end
