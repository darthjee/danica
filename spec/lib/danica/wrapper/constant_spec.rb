require 'spec_helper'

describe Danica::Wrapper::Constant do
  subject { described_class.new(2.5, :M, :m) }
  let(:other) { described_class.new(3, :N, :n) }

  it_behaves_like 'an object that respond to basic_methods'
  it_behaves_like 'an object with basic operation'

  describe '#to_f' do
    it 'has a value' do
      expect(subject.to_f).to eq(2.5)
    end
  end

  describe '#to_tex' do
    it 'has a string for latex' do
      expect(subject.to_tex).to eq('M')
    end
  end

  describe '#to' do
    context 'when requesting :tex' do
      it 'has a string for latex' do
        expect(subject.to(:tex)).to eq('M')
      end
    end
    context "when requesting 'tex'" do
      it 'has a string for latex' do
        expect(subject.to('tex')).to eq('M')
      end
    end
    context 'when requesting :gnu' do
      it 'has a string for gnu' do
        expect(subject.to(:gnu)).to eq('m')
      end
    end
    context "when requesting 'gnu'" do
      it 'has a string for gnu' do
        expect(subject.to('gnu')).to eq('m')
      end
    end
    context "when requesting wrong format" do
      it do
        expect do
          subject.to('format')
        end.to raise_error(Danica::Exception::FormatNotFound)
      end
    end
  end

  describe '#to_gnu' do
    it 'has a string for gnu' do
      expect(subject.to_gnu).to eq('m')
    end
  end

  describe 'attr_setters' do
    it { expect(subject).not_to respond_to(:value=) }
    it { expect(subject).not_to respond_to(:latex=) }
    it { expect(subject).not_to respond_to(:gnu=) }
  end

  context 'when initializing from hash' do
    subject { described_class.new(value: 2.5, latex: :M, gnu: :m) }

    it 'initialize normaly' do
      expect do
        described_class.new(value: 2.5, latex: :M, gnu: :m)
      end.not_to raise_error
    end

    it 'sets the value' do
      expect(subject.value).to eq(2.5)
    end

    it 'sets the latex' do
      expect(subject.to_tex).to eq('M')
    end

    it 'sets the gnu' do
      expect(subject.to_gnu).to eq('m')
    end
  end

  describe '==' do
    context 'when comparing with the same object' do
      it { expect(subject).to eq(subject) }
    end

    context 'when comparing with a diferent object' do
      context 'with diferent values' do
        it { expect(subject).not_to eq(other) }
      end

      context 'with same values' do
        let(:other) { described_class.new(2.5, :M, :m) }
        it { expect(subject).to eq(other) }
      end
    end
  end
end

