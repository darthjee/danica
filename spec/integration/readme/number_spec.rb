require 'spec_helper'

describe Danica::Wrapper::Number do
  let(:number) do
    Danica::Wrapper::Number.new(3)
  end

  subject do
    Danica::DSL.build do
      number(3)
    end
  end

  it do
    expect(subject).to eq(number)
  end

  describe 'from basic operation' do
    let(:sum) do
      Danica::DSL.build do
        power(:x, 2) + 3
      end
    end

    let(:expected) do
      Danica::Operator::Addition.new(
        Danica::Operator::Power.new(
          Danica::Wrapper::Variable.new(:x), 
          Danica::Wrapper::Number.new(2)
        ),
        Danica::Wrapper::Number.new(3)
      )
    end

    it do
      expect(sum).to eq(expected)
    end
  end
end

