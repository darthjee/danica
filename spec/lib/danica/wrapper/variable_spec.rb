# frozen_string_literal: true

require 'spec_helper'

describe Danica::Wrapper::Variable do
  subject(:variable) { described_class.new }

  it_behaves_like 'an object that respond to basic_methods'

  it_behaves_like 'an object with basic operation' do
    subject(:variable) { described_class.new(value: 100) }
  end

  it 'can be initialize from nil value' do
    expect do
      described_class.new(nil)
    end.not_to raise_error
  end

  it 'can be initialize from nil name' do
    expect do
      described_class.new(name: nil)
    end.not_to raise_error
  end

  describe '#to_f' do
    context 'when variable has no value' do
      it { expect { variable.to_f }.to raise_error(Danica::Exception::NotDefined) }
    end

    context 'when variable has value' do
      subject(:variable) { described_class.new(value: value) }

      let(:value) { 100 }

      it 'returns the value' do
        expect(variable.to_f).to eq(value)
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
