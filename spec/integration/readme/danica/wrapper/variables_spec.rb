# frozen_string_literal: true

require 'spec_helper'

describe Danica::Wrapper::Variable do
  describe '#to_tex' do
    context 'when initializing with the name' do
      subject(:variable) do
        described_class.new(:x)
      end

      it do
        expect(variable.to_tex).to eq('x')
      end
    end

    context 'when initializing with a hash' do
      subject(:variable) do
        described_class.new(name: :x)
      end

      it do
        expect(variable.to_tex).to eq('x')
      end
    end

    context 'when initializing from DSL' do
      subject(:variable) do
        Danica::DSL.build do
          variable(:x)
        end
      end

      it do
        expect(variable.to_tex).to eq('x')
      end
    end

    context 'when variable has value' do
      subject(:variable) do
        Danica::DSL.build do
          variable(name: :frequency, latex: '\lambda', gnuplot: :f, value: 2)
        end
      end

      it do
        expect(variable.to_tex).to eq('2')
      end
    end
  end

  describe '#to_f' do
    subject(:variable) do
      Danica::DSL.build do
        variable(name: :x, value: 2)
      end
    end

    it do
      expect(variable.to_f).to eq(2)
    end

    context 'when adding the value later' do
      subject(:variable) do
        Danica::DSL.build do
          variable(:x)
        end
      end

      let(:power) do
        variable = subject
        Danica::DSL.build do
          power(variable, 2)
        end
      end

      it do
        variable.value = 4
        expect(power.to_f).to eq(16)
      end
    end
  end

  describe 'custom outputs' do
    subject(:variable) do
      Danica::DSL.build do
        variable(name: :frequency, latex: '\lambda', gnuplot: :f)
      end
    end

    describe '#to_tex' do
      it do
        expect(variable.to_tex).to eq('\lambda')
      end
    end

    describe '#to_gnu' do
      it do
        expect(variable.to_gnu).to eq('f')
      end
    end
  end

  describe 'automatic wrapp' do
    let(:sum) do
      Danica::DSL.build do
        power(:x, name: :y) + :z
      end
    end

    let(:expected) do
      Danica::Operator::Addition.new(
        Danica::Operator::Power.new(
          described_class.new(:x),
          described_class.new(:y)
        ),
        described_class.new(:z)
      )
    end

    it do
      expect(sum).to eq(expected)
    end
  end
end
