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

  it_behaves_like 'a function that has two terms and knows how to calculate it', :division, {
    values: [ 2, 4 ],
    calculated: 1.0 / 2.0
  }

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

