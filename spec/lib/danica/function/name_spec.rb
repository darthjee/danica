require 'spec_helper'

describe Danica::Function::Name do
  let(:x) {  Danica::Wrapper::Variable.new(name: :x)}
  let(:subject) { described_class.new(name: :f, variables: [x]) }

  describe '#to_tex' do
    it 'returns the name of the function with tex variables' do
      expect(subject.to_tex).to eq('f(x)')
    end

    context 'when initializing variables from scratch' do
      let(:x) { :x }

      it 'returns the name of the function with tex variables' do
        expect(subject.to_tex).to eq('f(x)')
      end
    end
  end
end
