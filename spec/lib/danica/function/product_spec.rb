require 'spec_helper'

describe Danica::Function::Product do
  let(:variables_number) { 4 }
  let(:variables) do
    Array.new(variables_number).map.with_index do |_,i|
      Danica::Variable.new(name: "X#{i}", value: i+1)
    end
  end
  let(:subject) do
    described_class.new(variables: variables)
  end

  describe 'calculate' do
    it do
      expect(subject.calculate).to eq(24)
    end
  end
end
