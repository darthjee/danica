require 'spec_helper'

describe Danica::Expression::Baskara do
  describe '#to_tex' do
    it 'returns bascara tex string' do
      expect(subject.to_tex).to eq('\frac{-b \pm \sqrt{b^{2} -4 \cdot a \cdot c}}{2 \cdot a}')
    end
  end
end

describe Danica::Expression do
  let(:clazz) do
    described_class.build(:a, :b, :c) do
       (
         negative(b) + Danica::Wrapper::PlusMinus.new(
           squared_root(
             power(b, 2) - multiplication(4, a, c)
           )
         )
       ) / (number(2) * a)
    end
  end
  subject { clazz.new }

  describe 'to_tex' do
    it 'returns bascara tex string' do
      expect(subject.to_tex).to eq('\frac{-b \pm \sqrt{b^{2} -4 \cdot a \cdot c}}{2 \cdot a}')
    end
  end
end
