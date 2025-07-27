# frozen_string_literal: true

require 'spec_helper'

describe Danica::Function::MyFunction do
  describe '#to_gnu' do
    it 'returns the function' do
      expect(subject.to_gnu).to eq('f(x, y) = x**(2) + y')
    end
  end
end
