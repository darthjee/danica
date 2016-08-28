require 'spec_helper'

describe Danica::Function::SquareRoot do
  let(:variables_number) { 4 }
  let(:variable) { { name: "X", value: 9 } }
  let(:subject) do
    described_class.new(variable: variable)
  end

  describe 'to_f' do
    context 'when variables are not numbers but have value' do
      it 'returns the division of the values' do
        expect(subject.to_f).to eq(3.0)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end

    context 'when the variable is a number' do
      let(:variable) { 9 }

      it 'returns the squared root of the value' do
        expect(subject.to_f).to eq(3.0)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end
  end

  describe 'to_tex' do
    context 'when variables have no value' do
      let(:variable) { :X }

      it 'returns a latex format fraction' do
        expect(subject.to_tex).to eq('\sqrt{X}')
      end
    end

    context 'when the variable is numeric' do
      before do
        subject.variable.value = 9
      end
      it 'prints both numbers' do
        expect(subject.to_tex).to eq('3')
      end
    end
  end
end

