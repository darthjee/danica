require 'spec_helper'

module Danica
  module Common
    class Dummy
      include Common

      def to_tex
        'tex'
      end

      def to_gnu
        'gnu'
      end
    end

    class Dummy2
      include Common

      def to(format)
        "formatted: #{format}"
      end
    end
  end
end

describe Danica::Common do
  let(:clazz) { described_class::Dummy }
  subject { clazz.new }

  describe '#to_f' do
    it do
      expect do
        subject.to_f
      end.to raise_error(Danica::Exception::NotImplemented)
    end
  end

  describe '#to' do
    context 'when defining to_tex and to_gnu' do
      context 'when requesting :tex' do
        it 'has a string for latex' do
          expect(subject.to(:tex)).to eq('tex')
        end
      end
      context "when requesting 'tex'" do
        it 'has a string for latex' do
          expect(subject.to('tex')).to eq('tex')
        end
      end
      context 'when requesting :gnu' do
        it 'has a string for gnu' do
          expect(subject.to(:gnu)).to eq('gnu')
        end
      end
      context "when requesting 'gnu'" do
        it 'has a string for gnu' do
          expect(subject.to('gnu')).to eq('gnu')
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
  end

  describe '#to_tex' do
    context 'when defined the #to method' do
      let(:clazz) { described_class::Dummy2 }
      it 'returns the call of #to(:tex)' do
        expect(subject.to_tex).to eq('formatted: tex')
      end
    end
  end

  describe '#to_gnu' do
    context 'when defined the #to method' do
      let(:clazz) { described_class::Dummy2 }
      it 'returns the call of #to(:gnu)' do
        expect(subject.to_gnu).to eq('formatted: gnu')
      end
    end
  end

  describe '#tex' do
    it do
      expect(subject.tex).to be_a(Danica::Format)
    end

    it 'knows how to return a tex string' do
      expect(subject.tex.to_s).to eq('tex')
    end
  end

  describe '#gnu' do
    it do
      expect(subject.gnu).to be_a(Danica::Format)
    end

    it 'knows how to return a gnu string' do
      expect(subject.gnu.to_s).to eq('gnu')
    end
  end
end
