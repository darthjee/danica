# frozen_string_literal: true

require 'spec_helper'

describe Danica::Operator::Power do
  describe 'of additions' do
    subject do
      described_class.new(
        Danica::Operator::Addition.new(3, 4),
        Danica::Operator::Addition.new(5, 6)
      )
    end

    describe '#to_gnu' do
      it 'returns the correct string' do
        expect(subject.to_gnu).to eq('(3 + 4)**(5 + 6)')
      end
    end

    describe '#to_tex' do
      it 'returns the correct string' do
        expect(subject.to_tex).to eq('\left(3 + 4\right)^{5 + 6}')
      end
    end
  end
end
