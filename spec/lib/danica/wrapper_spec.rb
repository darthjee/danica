require 'spec_helper'

class Danica::Wrapper::Dummy
  include Danica::DSL
  include Danica::Wrapper

  attr_reader :wrapped_value

  def initialize(value)
    @wrapped_value = wrap_value(value)
  end
end

shared_examples 'a value wrapper' do |examples|
  examples.each do |val, expected|
    context "when value is a #{val.class}" do
      let(:value) { val }

      it do
        expect(subject.wrapped_value).to be_a(expected)
      end
    end
  end
end

describe Danica::Wrapper do
  let(:clazz) { described_class::Dummy }
  subject { clazz.new(value) }

  describe 'wrap_value' do
    it_behaves_like 'a value wrapper', {
      x: Danica::Wrapper::Variable,
      'x' => Danica::Wrapper::Variable,
      10 => Danica::Wrapper::Number,
      -10 => Danica::Wrapper::Negative,
      { name: :x } => Danica::Wrapper::Variable
    }

    context 'when value is a Hash' do
      context 'but it is a constant' do
        let(:value) { { value: 10, latex: :x, gnu: :X } }

        it do
          expect(subject.wrapped_value).to be_a(Danica::Wrapper::Constant)
        end
      end
    end
  end
end