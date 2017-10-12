require 'spec_helper'

class Danica::Common::Dummy
  include Danica::Common

  def to_tex
    'tex'
  end

  def to_gnu
    'gnu'
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
end
