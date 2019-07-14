# frozen_string_literal: true

require 'spec_helper'

describe Danica::Equation do
  subject do
    clazz.new
  end

  let(:clazz) do
    described_class.build(:x, :y) do
      left { y }
      right { x**2 }
    end
  end

  it_behaves_like 'an object that respond to basic_methods'

  describe '.build' do
    it 'returns a class that is also an equation' do
      expect(subject).to be_a(described_class)
    end
  end

  describe '.create' do
    subject do
      described_class.create(:x, :y) do
        left { y }
        right { x**2 }
      end
    end

    it 'returns a class that is also an equation' do
      expect(subject).to be_a(described_class)
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
