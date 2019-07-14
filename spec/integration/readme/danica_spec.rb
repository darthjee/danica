# frozen_string_literal: true

require 'spec_helper'

describe Danica do
  describe 'formatting' do
    subject do
      value = 1 / 3.0
      described_class.build(:x) do
        x + value
      end
    end

    describe '#to_tex' do
      it 'formats the output' do
        expect(subject.to_tex(decimals: 3)).to eq('x + 0.333')
      end
    end
  end

  describe '.build' do
    context 'when building an expression' do
      let(:expression) do
        described_class.build do
          (number(1) + 2) * power(3, 4)
        end
      end

      it do
        expect(expression).to be_a(Danica::Expression)
      end
    end

    context 'when building a function' do
      let(:function) do
        described_class.build do
          Danica::Function.create(:x, :y) do
            (number(1) + x) * power(3, y)
          end
        end
      end

      it do
        expect(function).to be_a(Danica::Function)
      end
    end
  end
end
