require 'spec_helper'

describe 'formatting' do
  subject do
    value = 1 / 3.0
    Danica.build(:x) do
      x + value
    end
  end

  describe '#to_tex' do
    it 'formats the output' do
      expect(subject.to_tex(decimals: 3)).to eq('x + 0.333')
    end
  end
end

describe Danica::Formatted do
  let(:expression) do
    value = 1 / 3.0
    Danica.build(:x) do
      x + value
    end
  end
  subject do
    expression.tex(decimals: 3)
  end

  describe '#to_tex' do
    it 'formats the output' do
      expect(subject.to_s).to eq('x + 0.333')
    end
  end
end
