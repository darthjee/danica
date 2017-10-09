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

  describe '#variables=' do
    before do
      subject.variables = variables
    end

    context 'when setting the variables using a list' do
      let(:variables) { [1, 2, 3] }

      it 'changes the values of the variables' do
        expect(subject.x).to eq(Danica::Wrapper::Number.new(1))
      end
    end

    context 'when setting the variales using a hash' do
      let(:variables) { { x: 1, y: 2, z: 3 } }

      it 'changes the values of the variables' do
        expect(subject.x).to eq(Danica::Wrapper::Number.new(1))
      end
    end
  end

  describe '#variables' do
    context 'when instance has no variables defined' do
      it do
        expect(subject.variables).not_to be_empty
      end

      it 'returns the base variables set on the class' do
        expect(subject.variables).to eq(clazz.variables_hash.values)
      end
    end

    context 'when some variables where defined' do
      before do
        subject.y = 1
      end

      it 'returns the default variables and the new set one' do
        expect(subject.variables).to eq(clazz.variables_hash.merge(
          y: Danica::Wrapper::Number.new(1)
        ).values)
      end

      it 'does not change the class variables' do
        expect do
          subject.z = 2
        end.not_to change { clazz.variables_hash }
      end
    end
  end

  describe '#variables_hash' do
    context 'when instance has no variables defined' do
      it 'returns the variables map with default values' do
        expect(subject.variables_hash).to eq(clazz.variables_hash)
      end
    end

    context 'when some variables where defined' do
      before do
        subject.y = 1
      end

      it 'returns the default hash with the set value' do
        expect(subject.variables_hash).to eq(clazz.variables_hash.merge(
          y: Danica::Wrapper::Number.new(1)
        ))
      end
    end
  end
  
  describe '#variables_value_hash' do
    context 'when instance has no variables defined' do
      it 'returns the default value' do
        expect(subject.variables_value_hash).to eq({x: nil, y: nil, z: 10})
      end
    end

    context 'when some of the variables have been valued' do
      before do
        subject.y = 1
      end

      it 'returns the values' do
        expect(subject.variables_value_hash).to eq({x: nil, y: 1, z: 10})
      end
    end
  end
end
