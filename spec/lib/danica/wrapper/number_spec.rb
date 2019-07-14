# frozen_string_literal: true

require 'spec_helper'

describe Danica::Wrapper::Number do
  subject { described_class.new(value) }

  let(:value) { 10 }

  it_behaves_like 'an object that respond to basic_methods'

  it_behaves_like 'an object with basic operation'

  describe '#valued?' do
    context 'when value is present' do
      it { expect(subject).to be_valued }
    end

    context 'when value is not present' do
      let(:value) { false }

      it { expect(subject).not_to be_valued }
    end
  end

  describe '#to_f' do
    it 'returns the float of value' do
      expect(subject.to_f).to eq(10)
    end

    it { expect(subject.to_f).to be_a(Float) }
  end

  describe '#to_tex' do
    it_behaves_like 'a method that display the numeric value', :to_tex
  end

  describe '#to_gnu' do
    it_behaves_like 'a method that display the numeric value', :to_gnu
  end
end
