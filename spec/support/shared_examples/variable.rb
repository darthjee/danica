shared_examples 'a variable method to formated string' do |method, format|
  let(:name) { :delta }
  let(:value) { 10.0 }
  let(:arguments) { { name: name, latex: '\delta', gnu: 'del' } }
  let(:subject) { described_class.new(arguments) }

  context "when #{format} is not defined" do
    before { arguments.delete(format) }

    it 'returns name' do
      expect(subject.public_send(method)).to eq('delta')
    end

    context 'when value is defined' do
      before { arguments[:value] = value }

      it 'returns the value' do
        expect(subject.public_send(method)).to eq('10')
      end
    end
  end

  context "when #{format} has been defined" do
    it "returns #{format}" do
      expect(subject.public_send(method)).to eq(arguments[format])
    end
  end
end
