require 'spec_helper'

class Danica::Common::Dummy
  include Danica::Common
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
end
