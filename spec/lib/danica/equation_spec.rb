require 'spec_helper'

describe Danica::Equation do
  let(:left) do
    Danica::Expression.create(:y) { y }
  end
  let(:right) do
    Danica::Expression.create(:x) { x ** 2 }
  end

  subject { described_class.new(left, right) }

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
