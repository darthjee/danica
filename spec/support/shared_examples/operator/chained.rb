shared_examples 'a operator that joins many variables with same operation' do |arguments|
  it_behaves_like 'a operator that knows how to calculate', arguments
  it_behaves_like 'a operator that knows how to write to tex', arguments
  it_behaves_like 'a operator that knows how to write to gnu', arguments
end

shared_examples 'a operator that knows how to calculate' do |arguments|
  include_context 'variables are initialized', arguments, 'calculated'
  let(:variables) do
    (1..4).map do |i|
      { name: "X#{i}", value: numeric_variables[i-1] }
    end
  end
  let(:numeric_variables){ (1..4).to_a }
  let(:subject) do
    described_class.new(*variables)
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

shared_examples 'a operator that knows how to write to tex' do |arguments|
  it_behaves_like 'a operator that knows how to write to a string', :to_tex, arguments
end

shared_examples 'a operator that knows how to write to gnu' do |arguments|
  it_behaves_like 'a operator that knows how to write to a string', :to_gnu, arguments
end

shared_examples 'a operator that knows how to write to a string' do |command, arguments|
  let(:numeric_variables) { arguments[:numeric_variables]  }
  include_context 'variables are initialized', arguments[command], *%w(integer_expected string_expected float_expected)
  let(:subject) do
    described_class.new(*variables)
  end

  describe "#{command}" do
    let(:variables) do
      (1..4).map { |i| "X#{i}" }
    end

    context 'when variables have no value' do
      it 'outputs a text format' do
        expect(subject.public_send(command)).to eq(string_expected)
      end
    end

    context 'when some variables have values' do
      let(:numeric_variables_index) { 1 }
      before do
        (0..numeric_variables_index).each do |i|
          subject.variables[i].value = numeric_variables[i]
        end
      end

      it 'outputs a latex format with colapsed numbers' do
        expect(subject.public_send(command)).to eq(integer_expected)
      end

      context 'when numeric variables calculated is a float value' do
        let(:numeric_variables_index) { 2 }

        it 'outputs a text format with colapsed numbers' do
          expect(subject.public_send(command)).to eq(float_expected)
        end
      end
    end

    context 'when some variables are numbers' do
      let(:numeric_variables_index) { 1 }
      before do
        (0..numeric_variables_index).each do |i|
          variables[i] = numeric_variables[i]
        end
      end

      it 'outputs a text format with colapsed numbers' do
        expect(subject.public_send(command)).to eq(integer_expected)
      end

      context 'when numeric variables calculated is a float value' do
        let(:numeric_variables_index) { 2 }

        it 'outputs a text format with colapsed numbers' do
          expect(subject.public_send(command)).to eq(float_expected)
        end
      end
    end
  end
end
