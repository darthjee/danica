# frozen_string_literal: true

require 'spec_helper'

shared_examples 'a formatted result' do |output|
  it do
    expect(result).to be_a(described_class)
  end

  it 'keeps being able to parse format' do
    expect(result.to_s).to eq(output)
  end
end

shared_examples('a formatted object that responds to basic operations') do |operations_map|
  operations_map.each do |operation, (output, reverse_output)|
    describe(operation.to_s) do
      let(:result) { formatted.public_send(operation, 2) }

      it_behaves_like 'a formatted result', output

      context 'when doing it backwards' do
        let(:result) { Danica::Wrapper::Number.new(2).public_send(operation, formatted) }

        it_behaves_like 'a formatted result', reverse_output
      end
    end
  end
end

describe Danica::Formatted do
  subject(:formatted) do
    described_class.new(content, format: format, **options)
  end

  let(:content) { Danica::Wrapper::Variable.new(latex: :V, gnuplot: :v) }
  let(:format) { :tex }
  let(:options) { {} }

  describe '#repack' do
    let(:expression) { Danica::Wrapper::Number.new(1.0 / 3) }

    it do
      expect(formatted.repack(expression)).to be_a(described_class)
    end

    context 'when there are options' do
      let(:options) { { decimals: 3 } }

      it 'wraps expression with options' do
        expect(formatted.repack(expression).to_s).to eq('0.333')
      end
    end
  end

  describe '#to_s' do
    context 'when format is tex' do
      it 'return the expected tex string' do
        expect(formatted.to_s).to eq('V')
      end
    end

    context 'when format is gnu' do
      let(:format) { :gnu }

      it 'return the expected gnu string' do
        expect(formatted.to_s).to eq('v')
      end
    end

    context 'when variable has numeric value' do
      let(:content) { Danica::Wrapper::Number.new(1 / 3.0) }

      it 'returns the formatted number' do
        expect(formatted.to_s).to eq('0.3333333333333333')
      end

      context 'when passing decimals settings' do
        let(:options) { { decimals: 4 } }

        it 'returns the formatted number' do
          expect(formatted.to_s).to eq('0.3333')
        end
      end
    end
  end

  describe 'operators' do
    it_behaves_like 'a formatted object that responds to basic operations',
                    :+ => ['V + 2', '2 + V'],
                    :- => ['V -2', '2 -V'],
                    :* => ['V \cdot 2', '2 \cdot V'],
                    :/ => ['\frac{V}{2}', '\frac{2}{V}'],
                    :** => ['V^{2}', '2^{V}']

    describe '-@' do
      it do
        expect(-formatted).to be_a(described_class)
      end

      it 'keeps being able to parse format' do
        expect((-formatted).to_s).to eq('-V')
      end
    end
  end

  describe '#to_f' do
    let(:content) { Danica::Wrapper::Number.new(2) }

    it do
      expect(formatted.to_f).to be_a(Numeric)
    end

    it 'returns the number' do
      expect(formatted.to_f).to eq(2)
    end
  end

  describe '#to' do
    it do
      expect(formatted.to(:tex)).to be_a(String)
    end

    it 'returns the string' do
      expect(formatted.to(:tex)).to eq('V')
    end
  end

  describe '#tex' do
    it do
      expect(formatted.tex).to be_a(described_class)
    end

    context 'when original format is tex' do
      it 'returns the tex string' do
        expect(formatted.tex.to_s).to eq('V')
      end

      it 'returns similar object' do
        expect(formatted.tex).to eq(formatted)
      end
    end

    context 'when original format is gnu' do
      let(:format) { :gnu }

      it 'returns the tex string' do
        expect(formatted.tex.to_s).to eq('V')
      end

      it 'returns a new format object' do
        expect(formatted.tex).not_to eq(formatted)
      end
    end
  end

  describe '#gnu' do
    it do
      expect(formatted.gnu).to be_a(described_class)
    end

    context 'when original format is tex' do
      it 'returns the gnu string' do
        expect(formatted.gnu.to_s).to eq('v')
      end
    end

    context 'when original format is gnu' do
      let(:format) { :gnu }

      it 'returns the gnu string' do
        expect(formatted.gnu.to_s).to eq('v')
      end
    end
  end
end
