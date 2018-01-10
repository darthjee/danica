require 'spec_helper'

describe Danica::Wrapper::Variable do
  describe '#to_tex' do
    context 'when initializing with the name' do
      subject do
        Danica::Wrapper::Variable.new(:x)
      end

      it do
        expect(subject.to_tex).to eq('x')
      end
    end

    context 'when initializing with a hash' do
      subject do
        Danica::Wrapper::Variable.new(name: :x)
      end

      it do
        expect(subject.to_tex).to eq('x')
      end
    end

    context 'when initializing from DSL' do
      subject do
        Danica::DSL.build do
          variable(:x)
        end
      end

      it do
        expect(subject.to_tex).to eq('x')
      end
    end
  end

  describe 'custom outputs' do
    subject do
      Danica::DSL.build do
        variable(name: :frequency, latex: '\lambda', gnu: :f)
      end
    end

    describe '#to_tex' do
      it do
        expect(subject.to_tex).to eq('\lambda')
      end
    end

    describe '#to_gnu' do
      it do
        expect(subject.to_gnu).to eq('f')
      end
    end
  end

  describe 'automatic wrapp' do
    let(:sum) do
      Danica::DSL.build do
        power(:x, { name: :y }) + :z
      end
    end

    let(:expected) do
      Danica::Operator::Addition.new(
        Danica::Operator::Power.new(
          Danica::Wrapper::Variable.new(:x),
          Danica::Wrapper::Variable.new(:y)
        ),
        Danica::Wrapper::Variable.new(:z)
      )
    end

    it do
      expect(sum).to eq(expected)
    end
  end
end
