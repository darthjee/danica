require 'spec_helper'

class Danica::Expressable::Dummy
  include Danica::Expressable

  delegate :to, to: :the_block

  built_with :the_block
end

describe Danica::Expressable do
  let(:clazz) { described_class::Dummy }
  subject do
    clazz.create(:x) { x }
  end

  it_behaves_like 'an object that respond to basic_methods', ignore: %i(valued? container? is_grouped? priority)

  describe '.build' do
    it 'responds to build' do
      expect(clazz).to respond_to(:build)
    end

    it 'returns a child class object' do
      expect(clazz.build(:x) do
        x
      end.superclass).to be(clazz)
    end
  end

  describe '.create' do
    it 'responds to create' do
      expect(clazz).to respond_to(:create)
    end

    it do
      expect(clazz.create(:x) do
        x
      end).to be_a(clazz)
    end
  end
end
