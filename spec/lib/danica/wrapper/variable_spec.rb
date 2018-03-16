require 'spec_helper'

describe Danica::Wrapper::Variable do
  it_behaves_like 'an object that respond to basic_methods'

  it_behaves_like 'an object with basic operation' do
    subject { described_class.new(value: 100) }
  end

  it 'can be initialize from nil value' do
    expect do
      described_class.new(nil)
    end
  end

  it 'can be initialize from nil name' do
    expect do
      described_class.new(name: nil)
    end
  end

  describe '#to_f' do
    context 'when variable has no value' do
      it { expect { subject.to_f }.to raise_error(Danica::Exception::NotDefined) }
    end

    context 'when variable has value' do
      let(:value) { 100 }
      subject { described_class.new(value: value) }

      it 'returns the value' do
        expect(subject.to_f).to eq(value)
      end
    end
  end

  describe '#to_tex' do
    it_behaves_like 'a variable method to formated string', :to_tex, :latex
  end

  describe '#to_gnu' do
    it_behaves_like 'a variable method to formated string', :to_gnu, :gnuplot
  end
end
