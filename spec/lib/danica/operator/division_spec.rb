# frozen_string_literal: true

require 'spec_helper'

describe Danica::Operator::Division do
  subject(:operator) { described_class.new(*variables) }

  let(:variables) { [2, 4] }

  describe '#numerator' do
    it 'returns the numerator' do
      expect(operator.numerator).to eq(Danica::Wrapper::Number.new(2))
    end
  end

  describe '#denominator' do
    it 'returns the denominator' do
      expect(operator.denominator).to eq(Danica::Wrapper::Number.new(4))
    end
  end

  it_behaves_like 'an object that respond to basic_methods'
  it_behaves_like 'an object with basic operation'

  it_behaves_like 'a operator that has two terms', :division,
                  values: [2, 4],
                  calculated: 1.0 / 2.0,
                  to_tex: {
                    string_expected: '\frac{X1}{X2}',
                    numeric_string_expected: '\frac{2}{4}',
                    partial_string_expected: '\frac{2}{X2}'
                  },
                  to_gnu: {
                    string_expected: '(X1)/(X2)',
                    numeric_string_expected: '(2)/(4)',
                    partial_string_expected: '(2)/(X2)'
                  }

  describe 'more complex division' do
    describe 'of two additions' do
      subject(:operator) do
        described_class.new(
          Danica::Operator::Addition.new(2, :x),
          Danica::Operator::Addition.new(3, :y)
        )
      end

      describe 'to_gnu' do
        let(:expected) do
          '(2 + x)/(3 + y)'
        end

        it 'groups addition' do
          expect(operator.to_gnu).to eq(expected)
        end
      end
    end
  end
end
