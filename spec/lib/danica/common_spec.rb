require 'spec_helper'

module Danica
  module Common
    class Dummy
      include Common

      def to_tex(**options)
        options.empty? ? 'tex' : "tex #{options}"
      end

      def to_gnu(**options)
        options.empty? ? 'gnu' : "gnu #{options}"
      end
    end

    class Dummy2
      include Common

      def to(format, **_)
        "formatted: #{format}"
      end
    end
  end
end

describe Danica::Common do
  let(:clazz) { described_class::Dummy }
  subject { clazz.new }
  it_behaves_like 'an object that respond to basic_methods'

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
          end.to raise_error(Danica::Exception::FormattedNotFound)
        end
      end
      context 'when passing options' do
        it 'passes the options ahead' do
          expect(subject.to(:gnu, { opt: 1 })).to eq('gnu {:opt=>1}')
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
      expect(subject.tex).to be_a(Danica::Formatted)
    end

    it 'knows how to return a tex string' do
      expect(subject.tex.to_s).to eq('tex')
    end

    context 'when passing options' do
      it 'uses the arguments' do
        expect(subject.tex(decimals: 3).to_s).to eq('tex {:decimals=>3}')
      end
    end
  end

  describe '#gnu' do
    it do
      expect(subject.gnu).to be_a(Danica::Formatted)
    end

    it 'knows how to return a gnu string' do
      expect(subject.gnu.to_s).to eq('gnu')
    end

    context 'when passing options' do
      it 'uses the arguments' do
        expect(subject.gnu(decimals: 3).to_s).to eq('gnu {:decimals=>3}')
      end
    end
  end

  describe '#formatted' do
    it do
      expect(subject.formatted(:gnu)).to be_a(Danica::Formatted)
    end

    it 'knows how to return to build the string string' do
      expect(subject.formatted(:gnu, decimals: 3).to_s).to eq('gnu {:decimals=>3}')
    end
  end
end
