# frozen_string_literal: true

require 'spec_helper'

describe Danica::Wrapper::PlusMinus do
  describe 'with a addition' do
    subject do
      described_class.new(
        Danica::Operator::Addition.new(1, 2, 3)
      )
    end

    describe '#to_gnu' do
      it 'returns the correct string' do
        expect(subject.to_gnu).to eq('+ (1 + 2 + 3)')
      end
    end

    describe '#to_tex' do
      it 'returns the correct string' do
        expect(subject.to_tex).to eq('\pm \left(1 + 2 + 3\right)')
      end
    end
  end
end
