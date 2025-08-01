# frozen_string_literal: true

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

      def to(format, **_options)
        "formatted: #{format}"
      end
    end
  end
end

describe Danica::Common do
  subject(:dummy) { clazz.new }

  let(:clazz) { described_class::Dummy }

  it_behaves_like 'an object that respond to basic_methods'

  describe '#to_f' do
    it do
      expect do
        dummy.to_f
      end.to raise_error(Danica::Exception::NotImplemented)
    end
  end

  describe '#to' do
    context 'when defining to_tex and to_gnu' do
      context 'when requesting :tex' do
        it 'has a string for latex' do
          expect(dummy.to(:tex)).to eq('tex')
        end
      end

      context "when requesting 'tex'" do
        it 'has a string for latex' do
          expect(dummy.to('tex')).to eq('tex')
        end
      end

      context 'when requesting :gnu' do
        it 'has a string for gnu' do
          expect(dummy.to(:gnu)).to eq('gnu')
        end
      end

      context "when requesting 'gnu'" do
        it 'has a string for gnu' do
          expect(dummy.to('gnu')).to eq('gnu')
        end
      end

      context 'when requesting wrong format' do
        it do
          expect do
            dummy.to('format')
          end.to raise_error(Danica::Exception::FormattedNotFound)
        end
      end

      context 'when passing options' do
        it 'passes the options ahead' do
          expect(dummy.to(:gnu, opt: 1)).to eq('gnu {:opt=>1}')
        end
      end
    end
  end

  describe '#to_tex' do
    context 'when defined the #to method' do
      let(:clazz) { described_class::Dummy2 }

      it 'returns the call of #to(:tex)' do
        expect(dummy.to_tex).to eq('formatted: tex')
      end
    end

    context 'when formatted was generated with gnu and with options' do
      subject(:dummy) { number.gnu(decimals: 3) }

      let(:number) { Danica::Wrapper::Number.new(1.0 / 3) }

      it 'formats with the current options' do
        expect(dummy.to_tex).to eq('0.333')
      end

      context 'when overwritting options' do
        it 'formats with the current options' do
          expect(dummy.to_tex(decimals: 4)).to eq('0.3333')
        end
      end
    end
  end

  describe '#to_gnu' do
    context 'when defined the #to method' do
      let(:clazz) { described_class::Dummy2 }

      it 'returns the call of #to(:gnu)' do
        expect(dummy.to_gnu).to eq('formatted: gnu')
      end
    end

    context 'when formatted was generated with tex and with options' do
      subject(:dummy) { number.tex(decimals: 3) }

      let(:number) { Danica::Wrapper::Number.new(1.0 / 3) }

      it 'formats with the current options' do
        expect(dummy.to_gnu).to eq('0.333')
      end

      context 'when overwritting options' do
        it 'formats with the current options' do
          expect(dummy.to_gnu(decimals: 4)).to eq('0.3333')
        end
      end
    end
  end

  describe 'to' do
    context 'when already formatted with options' do
      subject(:dummy) { number.tex(decimals: 3) }

      let(:number) { Danica::Wrapper::Number.new(1.0 / 3) }

      it 'uses to with options' do
        expect(dummy.to(:gnu)).to eq('0.333')
      end

      context 'when calling with options' do
        it 'uses options' do
          expect(dummy.to(:gnu, decimals: 4)).to eq('0.3333')
        end
      end
    end
  end

  describe '#tex' do
    it do
      expect(dummy.tex).to be_a(Danica::Formatted)
    end

    it 'knows how to return a tex string' do
      expect(dummy.tex.to_s).to eq('tex {:format=>:tex}')
    end

    context 'when passing options' do
      it 'uses the arguments' do
        expect(dummy.tex(decimals: 3).to_s).to eq('tex {:format=>:tex, :decimals=>3}')
      end
    end
  end

  describe '#gnu' do
    it do
      expect(dummy.gnu).to be_a(Danica::Formatted)
    end

    it 'knows how to return a gnu string' do
      expect(dummy.gnu.to_s).to eq('gnu {:format=>:gnu}')
    end

    context 'when passing options' do
      it 'uses the arguments' do
        expect(dummy.gnu(decimals: 3).to_s).to eq('gnu {:format=>:gnu, :decimals=>3}')
      end
    end
  end

  describe '#formatted' do
    it do
      expect(dummy.formatted(format: :gnu)).to be_a(Danica::Formatted)
    end

    it 'knows how to return to build the string string' do
      expect(dummy.formatted(format: :gnu, decimals: 3).to_s).to eq('gnu {:format=>:gnu, :decimals=>3}')
    end
  end
end
