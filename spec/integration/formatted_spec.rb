require 'spec_helper'

describe 'integration of formatted objects' do
  let(:variable) { Danica.build(:v) { v } }
  subject do
    variable.tex
  end

  context 'when interacting with a multiplication' do
    let(:other) do
      Danica.build(:x, :y) { x * y }
    end
    context 'when multipling another multiplication' do
      let(:result) { subject * other }
      it do
        expect(result).to be_a(Danica::Formatted)
      end

      it 'knows how to convert it to string' do
        expect(result.to_s).to eq('v \\cdot x \\cdot y')
      end
    end

    context 'when multiplicated by another multiplication' do
      let(:result) { other * subject }
      it do
        expect(result).to be_a(Danica::Formatted)
      end

      it 'knows how to convert it to string' do
        expect(result.to_s).to eq('x \\cdot y \\cdot v')
      end
    end
  end

  context 'when interacting with a sum' do
    let(:other) do
      Danica.build(:x, :y) { x + y }
    end
    context 'when summing another sum' do
      let(:result) { subject + other }
      it do
        expect(result).to be_a(Danica::Formatted)
      end

      it 'knows how to convert it to string' do
        expect(result.to_s).to eq('v + x + y')
      end
    end

    context 'when added by another sum' do
      let(:result) { other + subject }
      it do
        expect(result).to be_a(Danica::Formatted)
      end

      it 'knows how to convert it to string' do
        expect(result.to_s).to eq('x + y + v')
      end
    end
  end

  context 'when operating multiplication and subtraction all toguether' do
    let(:variable) { Danica::Wrapper::Variable.new(:v) }
    let(:x) { Danica::Wrapper::Variable.new(:x) }
    let(:result) { x * (-subject) }
    it do
      expect(result).to be_a(Danica::Formatted)
    end

    it 'knows how to convert it to string' do
      expect(result.to_s).to eq('x \cdot \left(-v\right)')
    end
  end
end
