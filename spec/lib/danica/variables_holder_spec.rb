require 'spec_helper'

describe Danica::VariablesHolder do
  class Danica::VariablesHolder::Dummy
    include Danica::Common
    include Danica::VariablesHolder

    variables :x, y: { latex: '\y' }, z: 10
  end

  let(:clazz) { described_class::Dummy }
  subject do
    clazz.new
  end

  it 'creates setters and getters for the variables' do
    %i(x y z).each do |var|
      expect(subject).to respond_to(var)
      expect(subject).to respond_to("#{var}=")
    end
  end

  describe '.variables_names' do
    it 'returns the list of variables pre configured' do
      expect(clazz.variables_names).to eq(%i(x y z))
    end
  end

  describe '#variables' do
    context 'when instance has no variables defined' do
      it do
        expect(subject.variables).not_to be_empty
      end

      it 'returns only nil values' do
        expect(subject.variables.compact).to be_empty
      end
    end

    context 'when some variables where defined' do
      before do
        subject.y = 1
      end

      it 'returns not only nil values' do
        expect(subject.variables).to eq([
          nil, Danica::Wrapper::Number.new(1), nil
        ])
      end
    end
  end

  describe '#variables_hash' do
    context 'when instance has no variables defined' do
      it 'returns the variables map with empty values' do
        expect(subject.variables_hash).to eq({x: nil, y: nil, z: nil})
      end
    end

    context 'when some variables where defined' do
      before do
        subject.y = 1
      end

      it 'returns not only nil values' do
        expect(subject.variables_hash).to eq({
          x: nil,
          y: Danica::Wrapper::Number.new(1),
          z: nil
        })
      end
    end
  end
  
  describe '#variables_value_hash' do
    context 'when instance has no variables defined' do
      it 'returns a nil valued hash' do
        expect(subject.variables_value_hash).to eq({x: nil, y: nil, z: nil})
      end
    end

    context 'when some of the variables have been valued' do
      before do
        subject.y = 1
      end

      it 'returns the values' do
        expect(subject.variables_value_hash).to eq({x: nil, y: 1, z: nil})
      end
    end
  end
end
