require 'spec_helper'

describe Danica::Function::Division do
  let(:values) { [ 2, 4 ] }
  let(:variables) do
    [ 1, 2 ].map do |i|
      { name: "X#{i}", value: values[i-1] }
    end
  end
  let(:subject) do
    described_class.new(numerator: variables[0], denominator: variables[1])
  end

  describe 'to_f' do
    context 'when variables are not numbers but have value' do
      it 'returns the division of the values' do
        expect(subject.to_f).to eq(1.0 / 2.0)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end

    context 'when all the variables are numbers' do
      let(:variables) { [ 2, 4 ] }

      it 'returns the division of the values' do
        expect(subject.to_f).to eq(1.0 / 2.0)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end

    context 'when one the variables are numbers' do
      before do
        variables[0] = 2
      end

      it 'returns the division of the values' do
        expect(subject.to_f).to eq(1.0 / 2.0)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end
  end

  describe 'to_tex' do
    context 'when variables have no value' do
      let(:variables) do
        [ 1,2 ].map { |i| "X#{i}" }
      end

      it 'returns a latex format fraction' do
        expect(subject.to_tex).to eq('\frac{X1}{X2}')
      end
    end

    context 'when one of the variables has value' do
      before do
        subject.denominator.value = nil
      end

      it 'returns the number instead of the value' do
        expect(subject.to_tex).to eq('\frac{2}{X2}')
      end
    end

    context 'when both variables are numeric' do
      it 'prints the result of the division' do
        expect(subject.to_tex).to eq('0.5')
      end
    end

    context 'when one of the variables is a number' do
      before do
        variables[0] = 1
        subject.denominator.value = nil
      end

      it 'prints both numbers' do
        expect(subject.to_tex).to eq('\frac{1}{X2}')
      end
    end
  end
end

