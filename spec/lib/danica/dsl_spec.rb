shared_context 'a class with mapped dsl' do
  mapping = {
    sum: Danica::Sum,
    product: Danica::Product,
    division: Danica::Division
  }

  let(:variables) { [2, 3] }

  mapping.each do |aliaz, clazz|
    it do
      expect(subject).to respond_to(aliaz)
    end

    it "has an alias #{aliaz} for #{clazz}" do
      expect(subject.public_send(aliaz, *variables)).to eq(clazz.new(*variables))
    end
  end
end

describe Danica::DSL do
  class Danica::DSL::Dummy
    include Danica::DSL
  end

  let(:subject) { described_class::Dummy.new }
  it_behaves_like 'a class with mapped dsl'
end
