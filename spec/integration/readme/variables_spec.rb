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
end
