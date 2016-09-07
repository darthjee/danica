require 'spec_helper'

describe Danica::Variable do
  describe '#to_f' do
    context 'when variable has no value' do
      it { expect { subject.to_f }.to raise_error(Danica::Exception::NotDefined) }
    end

    context 'when variable has value' do
      let(:value) { 100 }
      let(:subject) { described_class.new(value: value) }

      it 'returns the value' do
        expect(subject.to_f).to eq(value)
      end
    end
  end

  describe '#to_tex' do
    let(:name) { :delta }
    let(:value) { 10.0 }
    let(:arguments) { { name: name, latex: '\delta', gnu: 'del' } }
    let(:subject) { described_class.new(arguments) }

    context 'when latex is not defined ' do
      before { arguments.delete(:latex) }

      it 'returns name' do
        expect(subject.to_tex).to eq('delta')
      end

      context 'when value is defined' do
        before { arguments[:value] = value }

        it 'returns the value' do
          expect(subject.to_tex).to eq('10')
        end
      end
    end

    context 'when latex has been defined' do
      it 'returns latex' do
        expect(subject.to_tex).to eq('\delta')
      end
    end
  end

  describe '#to_gnu' do
    let(:name) { :delta }
    let(:value) { 10.0 }
    let(:arguments) { { name: name, latex: '\delta', gnu: 'del' } }
    let(:subject) { described_class.new(arguments) }

    context 'when gnu is not defined ' do
      before { arguments.delete(:gnu) }

      it 'returns name' do
        expect(subject.to_gnu).to eq('delta')
      end

      context 'when value has been defined' do
        before { arguments[:value] = value }

        it 'returns the value' do
          expect(subject.to_tex).to eq('10')
        end
      end
    end

    context 'when gnu has been defined' do
      it 'returns latex' do
        expect(subject.to_gnu).to eq('del')
      end
    end
  end
end
