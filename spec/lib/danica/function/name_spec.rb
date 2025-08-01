# frozen_string_literal: true

require 'spec_helper'

describe Danica::Function::Name do
  subject(:name) { described_class.new(name: :f, variables: [x]) }

  let(:x) { Danica::Wrapper::Variable.new(name: :x, latex: '\mu', gnuplot: 'u') }

  it_behaves_like 'an object that respond to basic_methods'

  describe '#to_tex' do
    it 'returns the name of the function with tex variables' do
      expect(name.to_tex).to eq('f(\mu)')
    end

    context 'when initializing variables from scratch' do
      let(:x) { :x }

      it 'returns the name of the function with tex variables' do
        expect(name.to_tex).to eq('f(x)')
      end
    end
  end

  describe '#to_gnu' do
    it 'returns the name of the function with tex variables' do
      expect(name.to_gnu).to eq('f(u)')
    end

    context 'when initializing variables from scratch' do
      let(:x) { :x }

      it 'returns the name of the function with tex variables' do
        expect(name.to_gnu).to eq('f(x)')
      end
    end
  end
end
