require 'spec_helper'

describe Danica::Function::Power do
  let(:values) { [ 3, 2 ] }
  let(:variables) do
    [ 1, 2 ].map do |i|
      { name: "X#{i}", value: values[i-1] }
    end
  end
  let(:subject) do
    described_class.new(base: variables[0], exponent: variables[1])
  end

  it_behaves_like 'a function that has two terms and knows how to calculate it', :division, {
    values: [ 3, 2 ],
    calculated: 9.0
  }

  describe 'to_tex' do
    context 'when variables have no value' do
      let(:variables) do
        [ 1,2 ].map { |i| "X#{i}" }
      end

      it 'returns a latex format fraction' do
        expect(subject.to_tex).to eq('X1^{X2}')
      end
    end

    context 'when one of the variables has value' do
      before do
        subject.exponent.value = nil
      end

      it 'returns both variables' do
        expect(subject.to_tex).to eq('3^{X2}')
      end
    end

    context 'when both variables are numeric' do
      it 'prints the final calculation' do
        expect(subject.to_tex).to eq('9')
      end
    end

    context 'when one of the variables is a number' do
      before do
        variables[0] = 1
        subject.exponent.value = nil
      end

      it 'prints both variables' do
        expect(subject.to_tex).to eq('1^{X2}')
      end
    end
  end
end

