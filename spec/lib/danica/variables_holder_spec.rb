require 'spec_helper'

shared_examples 'an object that returns the default variables hash' do
  it 'returns the default variables hash' do
    expect(subject.variables_hash).to eq(
      x: Danica::Wrapper::Variable.new(name: :x),
      y: Danica::Wrapper::Variable.new(latex: '\y'),
      z: Danica::Wrapper::Number.new(10)
    )
  end
end

shared_examples 'an object that returns the default variables' do
  it 'returns the default variables hash' do
    expect(subject.variables).to eq([
      Danica::Wrapper::Variable.new(name: :x),
      Danica::Wrapper::Variable.new(latex: '\y'),
      Danica::Wrapper::Number.new(10)
    ])
  end
end

shared_examples 'an variable set that does not change the class variables' do
  it 'does not change the the class variables' do
    expect do
      subject.variables = variables
    end.not_to change { clazz.variables_hash }
  end
end


describe Danica::VariablesHolder do
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

    context 'when variables are defined in super class' do
      let(:clazz) { described_class::DummyChild }

      it 'returns the list of variables of both classes merged' do
        expect(clazz.variables_names).to eq(%i(x y z k))
      end
    end

    context 'when variables are reseted on child class' do
      let(:clazz) { described_class::DummyOverwrite }

      it 'returns the list of variables of both classes merged' do
        expect(clazz.variables_names).to eq(%i(k z))
      end
    end

    context 'when we alias a variable' do
      let(:clazz) { described_class::DummyAlias }

      it 'returns the list of variables of both classes merged' do
        expect(clazz.variables_names).to eq(%i(a y z))
      end

      context 'when original variable is set' do
        before do
          subject.x = 10
        end

        context 'when calling the alias variable' do
          it 'returns the aliased value' do
            expect(subject.a).to eq(subject.x)
          end
        end

        context 'when changing the new alias value' do
          it do
            expect do
              subject.a = 20
            end.to change { subject.x.content }
          end
        end
      end

      context 'when alias variable is set' do
        before do
          subject.a = 10
        end

        context 'when calling the original variable' do
          it 'returns the aliased value' do
            expect(subject.x).to eq(subject.a)
          end
        end

        context 'when changing the original variable value' do
          it do
            expect do
              subject.x = 20
            end.to change { subject.a.content }
          end
        end
      end
    end
  end

  describe '#variables=' do
    context 'when changing the variables of the object' do
      context 'when all the variables are set with value' do
        let(:variables) { [1, 2, 3] }
        it_behaves_like 'an variable set that does not change the class variables'
      end

      context 'setting the variables through a hash' do
        let(:variables) { { x: 1, y: 2, z: 3 } }
        it_behaves_like 'an variable set that does not change the class variables'
      end

      context 'when none of the variables are set with values' do
        let(:variables) { [] }
        it_behaves_like 'an variable set that does not change the class variables'
      end

      context 'when the variables are set through an empty hash' do
        let(:variables) { {} }
        it_behaves_like 'an variable set that does not change the class variables'
      end
    end

    context 'when setting the variables using a list' do
      before do
        subject.variables = variables
      end
      let(:variables) { [1, 2, 3] }

      it 'changes the values of the variables' do
        expect(subject.x).to eq(Danica::Wrapper::Number.new(1))
      end

      context 'but the array is empty' do
        let(:variables) { [] }
        it_behaves_like 'an object that returns the default variables hash'
      end
    end

    context 'when setting the variales using a hash' do
      before do
        subject.variables = variables
      end

      let(:variables) { { x: 1, y: 2, z: 3 } }

      it 'changes the values of the variables' do
        expect(subject.x).to eq(Danica::Wrapper::Number.new(1))
      end

      context 'but the hash is empty' do
        let(:variables) { {} }
        it_behaves_like 'an object that returns the default variables hash'
      end
    end
  end

  describe '#variables' do
    context 'when instance has no variables defined' do
      it do
        expect(subject.variables).not_to be_empty
      end

      it_behaves_like 'an object that returns the default variables'
    end

    context 'when some variables where defined' do
      before do
        subject.y = 1
      end

      it 'returns the default variables and the new set one' do
        expect(subject.variables).to eq([
          Danica::Wrapper::Variable.new(name: :x),
          Danica::Wrapper::Number.new(1),
          Danica::Wrapper::Number.new(10)
        ])
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
      it_behaves_like 'an object that returns the default variables hash'
    end

    context 'when some variables where defined' do
      before do
        subject.y = 1
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

  describe '#containers' do
    it 'is an array of Containers' do
      expect(subject.containers.first).to be_a(Danica::Wrapper::Container)
    end

    context 'when changing the variable on the object' do
      let(:containers) { subject.containers }

      it 'changes the variables in the containers' do
        expect do
          subject.x = 2
        end.to change { containers.map(&:content) }
      end
    end
  end
end
