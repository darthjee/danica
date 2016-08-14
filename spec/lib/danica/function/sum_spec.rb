require 'spec_helper'

describe Danica::Function::Sum do
  let(:variables_number) { 4 }
  let(:variables) do
    (1..variables_number).map do |i|
      Danica::Variable.new(name: "X#{i}", value: i)
    end
  end
  let(:subject) do
    described_class.new(variables: variables)
  end

  describe 'to_f' do
    it 'returns the sum of variables value' do
      expect(subject.to_f).to eq(10)
    end

    it do
      expect(subject.to_f).to be_a(Float)
    end

    context 'when one variable is a number' do
      let(:variables) { (1..variables_number) }

       it do
        expect(subject.to_f).to eq(10)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end
  end

  describe 'to_tex' do
    context 'when variables have no value' do
      let(:variables) do
        (1..variables_number).map do |i|
          Danica::Variable.new(name: "X#{i}")
        end
      end

      it 'outputs a latex format' do
        expect(subject.to_tex).to eq('X1+X2+X3+X4')
      end
    end
  end
end
