require 'spec_helper'

describe Danica::Wrapper::Number do
  let(:value) { 10 }
  subject { described_class.new(value) }

  it_behaves_like 'an object that respond to basic_methods'

  it_behaves_like 'an object with basic operation'

  describe '#valued?' do
    context 'when value is present' do
      it { expect(subject.valued?).to be_truthy }
    end
    context 'when value is not present' do
      let(:value) { false }
      it { expect(subject.valued?).to be_falsey }
    end
  end

  describe '#to_f' do
    it 'returns the float of value' do
      expect(subject.to_f).to eq(10)
    end

    it { expect(subject.to_f).to be_a(Float) }
  end

  describe '#to_tex' do
    context 'when value should be integer' do
      let(:value) { 10.0 }

      it 'returns the value integer string' do
        expect(subject.to_tex).to eq('10')
      end

      context 'and passing the decimals argument' do
        it 'returns the value float string' do
          expect(subject.to_tex(decimals: 4)).to eq('10')
        end
      end
    end

    context 'when value should be a float' do
      let(:value) { 10 / 3.0 }

      it 'returns the value float string' do
        expect(subject.to_tex).to eq('3.3333333333333335')
      end

      context 'and passing the decimals argument' do
        it 'returns the value float string' do
          expect(subject.to_tex(decimals: 4)).to eq('3.3333')
        end
      end
    end
  end

  describe '#to_gnu' do
    context 'when value should be integer' do
      let(:value) { 10.0 }

      it 'returns the value integer string' do
        expect(subject.to_gnu).to eq('10')
      end

      context 'and passing the decimals argument' do
        it 'returns the value float string' do
          expect(subject.to_gnu(decimals: 4)).to eq('10')
        end
      end
    end

    context 'when value should be integer' do
      let(:value) { 10 / 3.0 }

      it 'returns the value integer string' do
        expect(subject.to_gnu).to eq('3.3333333333333335')
      end

      context 'and passing the decimals argument' do
        it 'returns the value float string' do
          expect(subject.to_gnu(decimals: 4)).to eq('3.3333')
        end
      end
    end
  end
end
