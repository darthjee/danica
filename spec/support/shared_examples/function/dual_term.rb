shared_examples 'a function that has two terms and knows how to calculate it' do |name, arguments|
  %w(values calculated).each do |key|
    let(key) { arguments[key.to_sym]  }
  end

  let(:variables) do
    [ 1, 2 ].map do |i|
      { name: "X#{i}", value: values[i-1] }
    end
  end

  describe '#to_f' do
    context 'when variables are not numbers but have value' do
      it "returns the #{name} of the values" do
        expect(subject.to_f).to eq(calculated)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end

    context 'when all the variables are numbers' do
      let(:variables) { values }

      it "returns the #{name} of the values" do
        expect(subject.to_f).to eq(calculated)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end

    context 'when one the variables are numbers' do
      before do
        variables[0] = values[0]
      end

      it "returns the #{name} of the values" do
        expect(subject.to_f).to eq(calculated)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end
  end
end
