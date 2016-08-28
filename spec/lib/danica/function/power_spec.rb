require 'spec_helper'

describe Danica::Function::Power do
  let(:variables_number) { 4 }
  let(:values) { [ 3, 2 ] }
  let(:variables) do
    [ 1, 2 ].map do |i|
      { name: "X#{i}", value: values[i-1] }
    end
  end
  let(:subject) do
    described_class.new(base: variables[0], exponent: variables[1])
  end

  describe 'to_f' do
    context 'when variables are not numbers but have value' do
      it 'returns the division of the values' do
        expect(subject.to_f).to eq(9.0)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end

    context 'when all the variables are numbers' do
      let(:variables) { [ 3, 2 ] }

      it 'returns the division of the values' do
        expect(subject.to_f).to eq(9.0)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end

    context 'when one the variables are numbers' do
      before do
        variables[0] = 3
      end

      it 'returns the division of the values' do
        expect(subject.to_f).to eq(9.0)
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
        expect(subject.to_tex).to eq('X1^X2')
      end
    end

    context 'when one of the variables has value' do
      before do
        subject.exponent.value = nil
      end

      it 'returns the number instead of the value' do
        expect(subject.to_tex).to eq('3^X2')
      end
    end

    context 'when both variables are numeric' do
      it 'prints both numbers' do
        expect(subject.to_tex).to eq('3^2')
      end
    end

    context 'when one of the variables is a number' do
      before do
        variables[0] = 1
        subject.exponent.value = nil
      end

      it 'prints both numbers' do
        expect(subject.to_tex).to eq('1^X2')
      end
    end
  end
end

