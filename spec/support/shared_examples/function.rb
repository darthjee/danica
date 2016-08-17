shared_examples 'a function that joins many variables with same operation' do |arguments|
  it_behaves_like 'a function that knows how to calculate', arguments
  it_behaves_like 'a function that knows how to write to tex', arguments
end

shared_examples 'a function that knows how to calculate' do |arguments|
  %w(calculated).each do |key|
    let(key) { arguments[key.to_sym]  }
  end
  let(:variables) do
    (1..4).map do |i|
      Danica::Variable.new(name: "X#{i}", value: numeric_variables[i-1])
    end
  end
  let(:numeric_variables){ (1..4).to_a }
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
      let(:variables) { (1..4) }

      it do
        expect(subject.to_f).to eq(calculated)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end
  end
end

shared_examples 'a function that knows how to write to tex' do |arguments|
  %w(numeric_variables tex_integer_expected tex_expected tex_float_expected).each do |key|
    let(key) { arguments[key.to_sym]  }
  end
  let(:subject) do
    described_class.new(variables: variables)
  end

  describe 'to_tex' do
    let(:variables) do
      (1..4).map do |i|
        Danica::Variable.new(name: "X#{i}")
      end
    end

    context 'when variables have no value' do
      it 'outputs a latex format' do
        expect(subject.to_tex).to eq(tex_expected)
      end
    end

    context 'when some variables have values' do
      let(:numeric_variables_index) { 1 }
      before do
        (0..numeric_variables_index).each do |i|
          variables[i].value = numeric_variables[i]
        end
      end

      it 'outputs a latex format with colapsed numbers' do
        expect(subject.to_tex).to eq(tex_integer_expected)
      end

      context 'when numeric variables sum is a float value' do
        let(:numeric_variables_index) { 2 }

        it 'outputs a latex format with colapsed numbers' do
          expect(subject.to_tex).to eq(tex_float_expected)
        end
      end
    end
  end
end
