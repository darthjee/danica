# frozen_string_literal: true

shared_examples 'a variable method to formated string' do |method, format|
  subject { described_class.new(arguments) }

  let(:name) { :delta }
  let(:value) { 10.0 }
  let(:arguments) { { name: name, latex: '\delta', gnuplot: 'del' } }

  context "when #{format} is not defined" do
    before { arguments.delete(format) }

    it 'returns name' do
      expect(subject.public_send(method)).to eq('delta')
    end

    context 'when value is defined' do
      before { arguments[:value] = value }

      it_behaves_like 'a method that display the numeric value', method
    end
  end

  context "when #{format} has been defined" do
    it "returns #{format}" do
      expect(subject.public_send(method)).to eq(arguments[format])
    end
  end
end

shared_examples 'a method that display the numeric value' do |method|
  context 'when value should be integer' do
    let(:value) { 10.0 }

    it 'returns the value integer string' do
      expect(subject.public_send(method)).to eq('10')
    end

    context 'when passing the decimals argument' do
      it 'returns the value float string' do
        expect(subject.public_send(method, decimals: 4)).to eq('10')
      end
    end
  end

  context 'when value should be a float' do
    let(:value) { 10 / 3.0 }

    it 'returns the value float string' do
      expect(subject.public_send(method)).to eq('3.3333333333333335')
    end

    context 'when passing the decimals argument' do
      it 'returns the value float string' do
        expect(subject.public_send(method, decimals: 4)).to eq('3.3333')
      end
    end

    context 'when the number has less decimals' do
      let(:value) { 10.5 }

      it 'returns the value integer string' do
        expect(subject.public_send(method, decimals: 4)).to eq('10.5')
      end
    end
  end
end
