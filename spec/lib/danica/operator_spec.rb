require 'spec_helper'

class Danica::Operator::Dummy < Danica::Operator
  variables :a, :b

  def to(*args)
    a + b
  end
end

describe Danica::Operator do
  let(:variables) { [2, 4] }
  let(:clazz) { described_class::Dummy }
  subject { clazz.new(*variables) }

  it_behaves_like 'an object that respond to basic_methods'

  describe 'variables assignment' do
    it 'assignes the variables tpo its places' do
      expect(subject.a).to eq(Danica::Wrapper::Number.new(2))
      expect(subject.b).to eq(Danica::Wrapper::Number.new(4))
    end

    context 'when initializing with a hash' do
      let(:variables) { [{ name: :A, value: 2 }, { name: :B, value: 4 }] }

      it 'assignes the variables tpo its places' do
        expect(subject.a).to eq(Danica::Wrapper::Variable.new(name: :A, value: 2))
        expect(subject.b).to eq(Danica::Wrapper::Variable.new(name: :B, value: 4))
      end
    end
  end
end
