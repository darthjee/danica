require 'spec_helper'

describe Danica::Function::Division do
  let(:variables_number) { 4 }
  let(:variables) do
    [ 2, 4 ].map do |i|
      Danica::Variable.new(name: "X#{i}", value: i)
    end
  end
  let(:subject) do
    described_class.new(numerator: variables[0], denominator: variables[1])
  end

  describe 'to_f' do
    it do
      expect(subject.to_f).to eq(1.0 / 2.0)
    end

    it do
      expect(subject.to_f).to be_a(Float)
    end

    context 'when one variable is a number' do
      let(:variables) { [ 2, 4 ] }

       it do
        expect(subject.to_f).to eq(1.0 / 2.0)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end
  end
end

