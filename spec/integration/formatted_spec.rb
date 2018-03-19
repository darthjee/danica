require 'spec_helper'

describe 'integration of formatted objects' do
  let(:multiplication) do
    Danica.build(:x, :y) { x * y }
  end
  let(:variable) { Danica.build(:v) { v } }
  subject do
    variable.tex
  end

  context 'when multipling another multiplication' do
    let(:result) { subject * multiplication }
    it do
      expect(result).to be_a(Danica::Formatted)
    end

    it 'knows how to convert it to string' do
      expect(result.to_s).to eq('v \\cdot x \\cdot y')
    end

    it 'rewraps the multiplication' do
      expect(result.variables).to include(multiplication.variables)
      expect(result.variables).to include(variable)
    end
  end

  context 'when multiplicated by another multiplication' do
    let(:result) { multiplication * subject }
    it do
      expect(result).to be_a(Danica::Formatted)
    end

    it 'knows how to convert it to string' do
      expect(result.to_s).to eq('v \\cdot x \\cdot y')
    end

    it 'rewraps the multiplication' do
      expect(result.variables).to include(multiplication.variables)
      expect(result.variables).to include(variable)
    end
  end
end
