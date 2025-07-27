# frozen_string_literal: true

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
        expect(wrapper.wrapped_value.content).to be_a(expected)
      end
    end
  end
end

describe Danica::Wrapper do
  subject(:wrapper) { clazz.new(value) }

  let(:clazz) { described_class::Dummy }

  describe 'wrap_value' do
    it_behaves_like 'a value wrapper',
                    x: Danica::Wrapper::Variable,
                    'x' => Danica::Wrapper::Variable,
                    10 => Danica::Wrapper::Number,
                    10.5 => Danica::Wrapper::Number,
                    -10 => Danica::Wrapper::Negative,
                    { name: :x } => Danica::Wrapper::Variable,
                    { value: 10, latex: :x, gnuplot: :X } => Danica::Wrapper::Constant,
                    Danica::Wrapper::Variable.new(:x).tex => Danica::Wrapper::Variable,
                    Danica.build(:x) { x } => Danica::Expression

    context 'when value is non accepted' do
      let(:value) { Object.new }

      it do
        expect do
          wrapper.wrapped_value.content
        end.to raise_error(Danica::Exception::InvalidInput)
      end
    end
  end
end
