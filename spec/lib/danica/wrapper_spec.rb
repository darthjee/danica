require 'spec_helper'

class Danica::Wrapper::Dummy
  include Danica::DSL
  include Danica::Wrapper

  attr_reader :wrapped_value

  def initialize(value)
    @wrapped_value = wrap_value(value)
  end
end

describe Danica::Wrapper do
  let(:clazz) { described_class::Dummy }
  subject { clazz.new(value) }

  describe 'wrap_value' do
    context 'when value is a number' do
      let(:value) { 10 }

      it do
        expect(subject.wrapped_value).to be_a(Danica::Wrapper::Number)
      end
    end

    context 'when value is a symbol' do
      let(:value) { :x }

      it do
        expect(subject.wrapped_value).to be_a(Danica::Wrapper::Variable)
      end
    end

    context 'when value is a string' do
      let(:value) { 'x' }

      it do
        expect(subject.wrapped_value).to be_a(Danica::Wrapper::Variable)
      end
    end

    context 'when value is a hash' do
      let(:value) { { name: :x } }

      it do
        expect(subject.wrapped_value).to be_a(Danica::Wrapper::Variable)
      end
    end
  end
end
