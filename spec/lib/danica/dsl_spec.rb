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
    sum: Danica::Sum,
    product: Danica::Product,
    division: Danica::Division,
    sin: Danica::Sin,
    cos: Danica::Cos,
    power: Danica::Power
  }.each do |aliaz, clazz|
    it_behaves_like 'a class with alias to a clazz', aliaz, clazz, 2, 3
  end
  {
    squared_root: Danica::SquaredRoot,
    exponential: Danica::Exponential,
    group: Danica::Group,
    negative: Danica::Negative,
    number: Danica::Number
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
