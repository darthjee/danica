require 'spec_helper'

describe Danica do
  describe '.build' do
    context 'when building an expression' do
      let(:expression) do
        Danica.build do
          (number(1) + 2) * power(3,4)
        end
      end

      it do
        expect(expression).to be_a(Danica::Expression)
      end
    end

    context 'when building a function' do
      let(:function) do
        Danica.build do
          Danica::Function.create(:x, :y) do
            (number(1) + x) * power(3, y)
          end
        end
      end

      it do
        expect(function).to be_a(Danica::Function)
      end
    end
  end
end

