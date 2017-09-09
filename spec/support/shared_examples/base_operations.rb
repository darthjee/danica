shared_examples 'an object with + operation' do
  let(:other) { 104 }
  it { expect(subject + other).to be_a(Danica::Sum) }
end
