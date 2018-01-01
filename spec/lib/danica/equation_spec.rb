require 'spec_helper'

describe Danica::Equation do
  let(:clazz) do
    described_class.build(:x, :y) do
      left { y }
      right { x ** 2 }
    end
  end

  subject do
    clazz.new
  end

  describe '.build' do
    it 'returns a class that is also an equation' do
      expect(subject).to be_a(Danica::Equation)
    end
  end

  describe '.create' do
    subject do
      described_class.create(:x, :y) do
        left { y }
        right { x ** 2 }
      end
    end

    it 'returns a class that is also an equation' do
      expect(subject).to be_a(Danica::Equation)
    end
  end

  describe '#to_f' do
    it do
      expect { subject.to_f }.to raise_error(Danica::Exception::NotImplemented)
    end
  end

  describe '#to_tex' do
    it 'joins the expressions in a equation' do
      expect(subject.to_tex).to eq('y = x^{2}')
    end
  end

  describe '#to_gnu' do
    it 'joins the expressions in a equation' do
      expect(subject.to_gnu).to eq('y = x**(2)')
    end
  end
end
