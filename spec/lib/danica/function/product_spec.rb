require 'spec_helper'

describe Danica::Function::Product do
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
    it do
      expect(subject.to_f).to eq(24)
    end

    it do
      expect(subject.to_f).to be_a(Float)
    end

    context 'when one variable is a number' do
      let(:variables) { (1..variables_number) }

       it do
        expect(subject.to_f).to eq(24)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end
  end
end
