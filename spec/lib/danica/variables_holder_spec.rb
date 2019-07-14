# frozen_string_literal: true

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
    end.not_to change(clazz, :variables_hash)
  end
end

shared_examples 'a class with mapped variables' do
  context 'when initializing with an array' do
    subject { clazz.new(1, 2, 3) }

    it 'initialize variables in order of declaration' do
      expect(subject.variables_hash).to eq(
        x: Danica::Wrapper::Number.new(1),
        y: Danica::Wrapper::Number.new(2),
        z: Danica::Wrapper::Number.new(3)
      )
    end
  end

  context 'when initialized with a hash' do
    subject { clazz.new(z: 1, y: 2) }

    it 'initialize variables with the map given' do
      expect(subject.variables_hash).to eq(
        x: Danica::Wrapper::Variable.new(name: :x),
        y: Danica::Wrapper::Number.new(2),
        z: Danica::Wrapper::Number.new(1)
      )
    end
  end

  context 'when initializing with hashes' do
    subject do
      clazz.new(
        { name: :xis, value: 1 },
        { name: :yps, value: 2 },
        name: :zes, value: 3
      )
    end

    it 'initialize variables with the maps given' do
      expect(subject.variables_hash).to eq(
        x: Danica::Wrapper::Variable.new(name: :xis, value: 1),
        y: Danica::Wrapper::Variable.new(name: :yps, value: 2),
        z: Danica::Wrapper::Variable.new(name: :zes, value: 3)
      )
    end
  end

  context 'when initializing with array of hashes' do
    subject do
      clazz.new([
                  { name: :xis, value: 1 },
                  { name: :yps, value: 2 },
                  { name: :zes, value: 3 }
                ])
    end

    it 'initialize variables with the maps given' do
      expect(subject.variables_hash).to eq(
        x: Danica::Wrapper::Variable.new(name: :xis, value: 1),
        y: Danica::Wrapper::Variable.new(name: :yps, value: 2),
        z: Danica::Wrapper::Variable.new(name: :zes, value: 3)
      )
    end
  end
end

describe Danica::VariablesHolder do
  subject { clazz.new }

  let(:clazz) { described_class::Dummy }

  describe '#initialize' do
    context 'when using a symbolized key definition' do
      it_behaves_like 'a class with mapped variables'
    end

    context 'when using a string key definition' do
      let(:clazz) { described_class::DummyString }

      it_behaves_like 'a class with mapped variables'
    end
  end

  describe 'variables assignement' do
    it 'creates setters and getters for the variables' do
      %i[x y z].each do |var|
        expect(subject).to respond_to(var)
        expect(subject).to respond_to("#{var}=")
      end
    end

    it 'accepts variable assignment' do
      expect do
        subject.x = 1
      end.to change(subject.x, :content).to(Danica::Wrapper::Number.new(1))
    end

    it 'variable assignemnt does not change the container' do
      expect do
        subject.x = 1
      end.not_to change(subject, :x)
    end

    xit 'accepts containter assignment' do
      expect do
        subject.x = Danica::Wrapper::Container.new(Danica::Wrapper::Number.new(1))
      end.to change(subject, :x)
    end
  end

  describe '.variables_names' do
    it 'returns the list of variables pre configured' do
      expect(clazz.variables_names).to eq(%i[x y z])
    end

    context 'when variables are defined in super class' do
      let(:clazz) { described_class::DummyChild }

      it 'returns the list of variables of both classes merged' do
        expect(clazz.variables_names).to eq(%i[x y z k])
      end
    end

    context 'when variables are reseted on child class' do
      let(:clazz) { described_class::DummyOverwrite }

      it 'returns the list of variables of both classes merged' do
        expect(clazz.variables_names).to eq(%i[k z])
      end
    end
  end

  describe 'variable alias' do
    context 'when we alias a variable' do
      let(:clazz) { described_class::DummyAlias }

      it 'returns the list of variables of both classes merged' do
        expect(clazz.variables_names).to eq(%i[a y z])
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
            expect { subject.a = 20 }.to(change { subject.x.content })
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
            expect { subject.x = 20 }
              .to(change { subject.a.content })
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
        end.not_to change(clazz, :variables_hash)
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
        expect(subject.variables_value_hash).to eq(x: nil, y: nil, z: 10)
      end
    end

    context 'when some of the variables have been valued' do
      before do
        subject.y = 1
      end

      it 'returns the values' do
        expect(subject.variables_value_hash).to eq(x: nil, y: 1, z: 10)
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
        expect {  subject.x = 2 }
          .to(change { containers.map(&:content) })
      end
    end
  end

  describe '#extract_variables' do
    let(:clazz) { described_class::DummyChild }

    context 'when holder has straight variables' do
      it 'returns the variables hash' do
        expect(subject.extract_variables).to eq(subject.containers.as_hash(%i[x y zeta k]))
      end

      context 'but one of them is a number' do
        let(:clazz) { described_class::Dummy }
        let(:expected) do
          subject.containers_hash.reject { |k, _v| k == :z }
        end

        it 'returns only the variables' do
          expect(subject.extract_variables).to eq(expected)
        end
      end
    end

    context 'when variables names are different' do
      let(:subject) { clazz.new(x: :xis, y: :lambda, z: :zeta, k: :key) }

      it 'returns the names as keys' do
        expect(subject.extract_variables.keys).to eq(%i[xis lambda zeta key])
      end
    end

    context 'when a variable is another variable holder' do
      let(:inner) { Danica::Operator::Power.new }
      let(:subject) do
        clazz.new(z: inner)
      end
      let(:expected) do
        subject.containers_hash.reject { |k, _v| k == :z }
               .merge(inner.containers_hash)
      end

      it 'returns the ineer variables of the inner holder as well' do
        expect(subject.extract_variables).to eq(expected)
      end

      context 'when inner holder has the same variables' do
        let(:inner) { clazz.new }
        let(:expected) do
          inner.containers.as_hash(%i[x y zeta k])
        end

        it 'merges them together in favor of the inner variables' do
          expect(subject.extract_variables).to eq(expected)
        end
      end
    end
  end

  describe '#calculate' do
    context 'when object doesnt have the values defined' do
      context 'when trying to calculate without passing the values' do
        it do
          expect { subject.calculate }.to raise_error(Danica::Exception::NotDefined)
        end

        context 'which does not complete the values' do
          it do
            expect { subject.calculate(2) }.to raise_error(Danica::Exception::NotDefined)
          end
        end
      end

      context 'when passing the values' do
        context 'as a list of values' do
          it do
            expect { subject.calculate(2, 4) }.not_to raise_error
          end

          it 'calculates the expression' do
            expect(subject.calculate(2, 4)).to eq(26)
          end

          context 'and replacing all the values' do
            it do
              expect { subject.calculate(2, 4, 5) }.not_to raise_error
            end

            it 'calculates the expression' do
              expect(subject.calculate(2, 4, 5)).to eq(21)
            end
          end
        end

        context 'as a hash' do
          context 'which completes the values' do
            it do
              expect { subject.calculate(x: 2, y: 4) }.not_to raise_error
            end

            it 'calculates the expression' do
              expect(subject.calculate(2, 4)).to eq(26)
            end
          end

          context 'which does not complete the values' do
            it do
              expect { subject.calculate(x: 2, z: 4) }.to raise_error(Danica::Exception::NotDefined)
            end
          end
        end
      end
    end
  end
end
