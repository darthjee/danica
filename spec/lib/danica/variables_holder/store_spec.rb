# frozen_string_literal: true

require 'spec_helper'

describe Danica::VariablesHolder::Store do
  subject do
    described_class.new(default_variables_hash)
  end

  let(:default_variables_hash) do
    {
      x: Danica::Wrapper::Variable.new(name: :x),
      y: Danica::Wrapper::Variable.new(latex: '\y'),
      z: Danica::Wrapper::Number.new(10)
    }
  end

  describe '#variables' do
    context 'when instance has no variables defined' do
      it do
        expect(subject.variables).not_to be_empty
      end

      # it_behaves_like 'an object that returns the default variables'
    end

    context 'when some variables where defined' do
      before do
        subject.containers_hash[:y] = Danica::Wrapper::Number.new(1)
      end

      let(:expected_variables) do
        [
          Danica::Wrapper::Variable.new(name: :x),
          Danica::Wrapper::Number.new(1),
          Danica::Wrapper::Number.new(10)
        ]
      end

      it 'returns the default variables and the new set one' do
        expect(subject.variables)
          .to eq(expected_variables)
      end

      it 'does not change the default variables' do
        expect do
          subject.containers_hash[:x] = Danica::Wrapper::Number.new(2)
        end.not_to change(subject, :default_variables_hash)
      end
    end
  end

  describe '#variables_hash' do
    context 'when instance has no variables defined' do
      # it_behaves_like 'an object that returns the default variables hash'
    end

    context 'when some variables where defined' do
      before do
        subject.containers_hash[:y] = Danica::Wrapper::Number.new(1)
      end

      it 'returns the default hash with the set value' do
        expect(subject.variables_hash).to eq(
          x: Danica::Wrapper::Variable.new(name: :x),
          y: Danica::Wrapper::Number.new(1),
          z: Danica::Wrapper::Number.new(10)
        )
      end
    end
  end

  describe '#containers' do
    it 'is an array of Containers' do
      expect(subject.containers).to all(be_a(Danica::Wrapper::Container))
    end
  end
end
