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

shared_examples 'a function that has two terms and knows how to call to_tex' do |arguments|
  %w(values string_expected numeric_string_expected partial_string_expected).each do |key|
    let(key) { arguments[key.to_sym]  }
  end
  describe 'to_tex' do
    let(:variables) do
      [ 1, 2 ].map do |i|
        { name: "X#{i}", value: values[i-1] }
      end
    end

    context 'when variables have no value' do
      let(:variables) do
        [ 1,2 ].map { |i| "X#{i}" }
      end

      it 'returns a latex format fraction' do
        expect(subject.to_tex).to eq(string_expected)
      end
    end

    context 'when one of the variables has value' do
      before do
        variables[1][:value] = nil
      end

      it 'returns the number instead of the value' do
        expect(subject.to_tex).to eq(partial_string_expected)
      end
    end

    context 'when both variables are numeric' do
      it 'prints the result of the division' do
        expect(subject.to_tex).to eq(numeric_string_expected)
      end
    end

    context 'when one of the variables is a number' do
      before do
        variables[0] = values[0]
        variables[1][:value] = nil
      end

      it 'prints both numbers' do
        expect(subject.to_tex).to eq(partial_string_expected)
      end
    end
  end
end

