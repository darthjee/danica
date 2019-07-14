# frozen_string_literal: true

require 'spec_helper'

describe Danica::Formatted do
  describe 'formatting' do
    subject do
      expression.tex(decimals: 3)
    end

    let(:expression) do
      value = 1 / 3.0
      Danica.build(:x) do
        x + value
      end
    end

    describe '#to_tex' do
      it 'formats the output' do
        expect(subject.to_s).to eq('x + 0.333')
      end
    end
  end
end
