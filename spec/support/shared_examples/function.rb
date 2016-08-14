shared_examples 'a function that joins many variables with same operation' do |arguments|
  let(:calculated) { arguments[:calculated] }
  let(:symbol) { arguments[:symbol] }

  let(:variables_number) { 4 }
  let(:variables) do
    (1..variables_number).map do |i|
      Danica::Variable.new(name: "X#{i}", value: i)
    end
  end
  let(:subject) do
    described_class.new(variables: variables)
  end

  describe 'to_f' do
    it 'returns the sum of variables value' do
      expect(subject.to_f).to eq(calculated)
    end

    it do
      expect(subject.to_f).to be_a(Float)
    end

    context 'when one variable is a number' do
      let(:variables) { (1..variables_number) }

      it do
        expect(subject.to_f).to eq(calculated)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end
  end

  describe 'to_tex' do
    context 'when variables have no value' do
      let(:variables) do
        (1..variables_number).map do |i|
          Danica::Variable.new(name: "X#{i}")
        end
      end

      it 'outputs a latex format' do
        expect(subject.to_tex).to eq(%w(X1 X2 X3 X4).join(symbol))
      end

      context 'when some variables have values' do
        before do
          (1..(variables_number / 2)).each do |i|
            variables[i-1].value = i + 0.5
          end
        end

        it 'outputs a latex format with colapsed numbers' do
          expect(subject.to_tex).to eq(%w(4 X3 X4).join(symbol))
        end

        context 'when numeric variables sum is a float value' do
          before do
            variables[2].value = 3.5
          end

          it 'outputs a latex format with colapsed numbers' do
            expect(subject.to_tex).to eq(%w(7.5 X4).join(symbol))
          end
        end
      end
    end
  end
end
