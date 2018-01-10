require 'spec_helper'

shared_context 'a class with alias to a clazz' do |aliaz, clazz, *variables|
  it do
    expect(subject).to respond_to(aliaz)
  end

  it "has an alias #{aliaz} for #{clazz}" do
    expect(subject.public_send(aliaz, *variables)).to eq(clazz.new(*variables))
  end
end

shared_context 'a class with mapped dsl' do
  {
    addition:       Danica::Operator::Addition,
    sum:            Danica::Operator::Addition,
    multiplication: Danica::Operator::Multiplication,
    product:        Danica::Operator::Multiplication,
    division:       Danica::Operator::Division,
    power:          Danica::Operator::Power
  }.each do |aliaz, clazz|
    it_behaves_like 'a class with alias to a clazz', aliaz, clazz, 2, 3
  end
  {
    squared_root:  Danica::Operator::SquaredRoot,
    sqrt:          Danica::Operator::SquaredRoot,
    exponential:   Danica::Operator::Exponential,
    sin:           Danica::Operator::Sin,
    cos:           Danica::Operator::Cos,
    group:         Danica::Wrapper::Group,
    negative:      Danica::Wrapper::Negative,
    number:        Danica::Wrapper::Number,
    num:           Danica::Wrapper::Number,
    plus_minus:    Danica::Wrapper::PlusMinus,
    constant:      Danica::Wrapper::Constant
  }.each do |aliaz, clazz|
    it_behaves_like 'a class with alias to a clazz', aliaz, clazz, 9
  end
end

describe Danica::DSL do
  class Danica::DSL::Dummy
    include Danica::DSL
  end

  let(:subject) { described_class::Dummy.new }
  it_behaves_like 'a class with mapped dsl'

  describe '.build' do
    let(:expected) do
      Danica::Operator::Addition.new(
        Danica::Wrapper::Number.new(2),
        Danica::Wrapper::Variable.new(:x)
      )
    end

    it 'executes the build block' do
      expect(described_class.build { number(2) + variable(:x) }).to eq(expected)
    end
  end
end
