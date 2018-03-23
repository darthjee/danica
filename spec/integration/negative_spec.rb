require 'spec_helper'

describe 'integration of negative' do
  describe 'with a addition' do
    subject do
      Danica::Wrapper::Negative.new(
        Danica::Operator::Addition.new(1,2,3)
      )
    end

    describe '#to_gnu' do
      it 'returns the correct string' do
        expect(subject.to_gnu).to eq('-(1 + 2 + 3)')
      end
    end

    describe '#to_tex' do
      it 'returns the correct string' do
        expect(subject.to_tex).to eq('-\left(1 + 2 + 3\right)')
      end
    end

    describe 'when it is the result of an expression' do
      let(:x) { Danica::Wrapper::Variable.new(:x) }
      let(:y) { Danica::Wrapper::Variable.new(:y) }
      let(:z) { Danica::Wrapper::Variable.new(:z) }
      let(:negative_parcel) { y + z }
      subject do
        x - negative_parcel
      end

      it 'wraps parcel into a group' do
        expect(subject.to_gnu).to eq('x -(y + z)')
      end

      context 'when the negative parcel is an expression' do
        let(:negative_parcel) { Danica.build(:y, :z) { y + z } }

        it 'wraps parcel into a group' do
          expect(subject.to_gnu).to eq('x -(y + z)')
        end

        context 'when negative has just one element' do
          let(:negative_parcel) { Danica.build(:y) { y } }

          it 'wraps parcel into a group' do
            expect(subject.to_gnu).to eq('x -y')
          end
        end
      end
    end
  end
end


