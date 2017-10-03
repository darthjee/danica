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
    sum: Danica::Operator::Sum,
    product: Danica::Operator::Product,
    division: Danica::Operator::Division,
    sin: Danica::Operator::Sin,
    cos: Danica::Operator::Cos,
    power: Danica::Operator::Power
  }.each do |aliaz, clazz|
    it_behaves_like 'a class with alias to a clazz', aliaz, clazz, 2, 3
  end
  {
    squared_root: Danica::Operator::SquaredRoot,
    exponential: Danica::Operator::Exponential,
    group: Danica::Wrapper::Group,
    negative: Danica::Wrapper::Negative,
    number: Danica::Wrapper::Number
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
end
