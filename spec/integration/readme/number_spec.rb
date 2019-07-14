# frozen_string_literal: true

require 'spec_helper'

describe Danica::Wrapper::Number do
  subject do
    Danica::DSL.build do
      number(3)
    end
  end

  let(:number) do
    described_class.new(3)
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
          described_class.new(2)
        ),
        described_class.new(3)
      )
    end

    it do
      expect(sum).to eq(expected)
    end
  end
end
