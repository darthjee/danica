require 'spec_helper'

describe Danica::Format do
  let(:content) { Danica::Wrapper::Variable.new(latex: :V, gnuplot: :v) }
  let(:format) { :tex }
  subject do
    described_class.new(content, format)
  end

  describe '#to_s' do
    context 'when format is tex' do
      it 'return the expected tex string' do
        expect(subject.to_s).to eq('V')
      end
    end

    context 'when format is gnu' do
      let(:format) { :gnu }

      it 'return the expected gnu string' do
        expect(subject.to_s).to eq('v')
      end
    end
  end

  describe 'operators' do
    describe '+' do
      it do
        expect(subject + 2).to be_a(described_class)
      end

      it 'keeps being able to parse format' do
        expect((subject + 2).to_s).to eq('V + 2')
      end
    end

    describe '*' do
      it do
        expect(subject * 2).to be_a(described_class)
      end

      it 'keeps being able to parse format' do
        expect((subject * 2).to_s).to eq('V \cdot 2')
      end
    end

    describe '-@' do
      it do
        expect(-subject).to be_a(described_class)
      end

      it 'keeps being able to parse format' do
        expect((-subject).to_s).to eq('-V')
      end
    end
  end

  describe '#to_f' do
    let(:content) { Danica::Wrapper::Number.new(2) }

    it do
      expect(subject.to_f).to be_a(Numeric)
    end

    it 'returns the number' do
      expect(subject.to_f).to eq(2)
    end
  end

  describe '#to' do
    it do
      expect(subject.to(:tex)).to be_a(String)
    end

    it 'returns the string' do
      expect(subject.to(:tex)).to eq('V')
    end
  end

  describe '#tex' do
    it do
      expect(subject.tex).to be_a(Danica::Format)
    end

    context 'when original format is tex' do
      it 'returns the tex string' do
        expect(subject.tex.to_s).to eq('V')
      end
    end

    context 'when original format is gnu' do
      let(:format) { :gnu }
      it 'returns the tex string' do
        expect(subject.tex.to_s).to eq('V')
      end
    end
  end

  describe '#gnu' do
    it do
      expect(subject.gnu).to be_a(Danica::Format)
    end

    context 'when original format is tex' do
      it 'returns the gnu string' do
        expect(subject.gnu.to_s).to eq('v')
      end
    end

    context 'when original format is gnu' do
      let(:format) { :gnu }
      it 'returns the gnu string' do
        expect(subject.gnu.to_s).to eq('v')
      end
    end
  end
end
