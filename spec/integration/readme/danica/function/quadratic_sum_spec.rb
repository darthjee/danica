# frozen_string_literal: true

require 'spec_helper'

describe Danica::Function::QuadraticSum do
  describe '#to_tex' do
    it 'creates a funcion out of an expression' do
      expect(subject.to_tex).to eq('f(x, y) = \\left(x + y\\right)^{2}')
    end
  end
end
