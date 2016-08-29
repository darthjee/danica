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
    let(:value) { 10 }

    context 'when latex is not defined ' do
      let(:subject) { described_class.new name: name }

      it 'returns name' do
        expect(subject.to_tex).to eq('delta')
      end
    end

    context 'when latex has been defined' do
      let(:subject) { described_class.new name: name, latex: '\delta' }

      it 'returns latex' do
        expect(subject.to_tex).to eq('\delta')
      end
    end
  end

  describe '#to_gnu' do
    let(:name) { :delta }

    context 'when gnu is not defined ' do
      let(:subject) { described_class.new name: name }

      it 'returns name' do
        expect(subject.to_gnu).to eq('delta')
      end
    end

    context 'when gnu has been defined' do
      let(:subject) { described_class.new name: name, gnu: 'del' }

      it 'returns latex' do
        expect(subject.to_gnu).to eq('del')
      end
    end
  end
end
