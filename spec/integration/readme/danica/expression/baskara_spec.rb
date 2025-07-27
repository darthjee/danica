# frozen_string_literal: true

require 'spec_helper'

describe Danica::Expression::Baskara do
  describe '#to_tex' do
    it 'returns bascara tex string' do
      expect(subject.to_tex).to eq('\frac{-b \pm \sqrt{b^{2} -4 \cdot a \cdot c}}{2 \cdot a}')
    end
  end
end
