# frozen_string_literal: true

require 'spec_helper'

describe Danica::Wrapper::Constant do
  subject(:constant) do
    described_class.new(gnuplot: 'pi', latex: '\pi', value: 3.141592)
  end

  let(:output) do
    {
      tex: '\pi',
      gnu: 'pi',
      f: 3.141592
    }
  end

  describe 'outputs' do
    it do
      output.each do |format, expected|
        expect(constant.to(format)).to eq(expected)
      end
    end
  end
end
