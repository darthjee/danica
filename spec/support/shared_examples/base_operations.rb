shared_examples 'an object with + operation' do
  let(:other) { 104 }
  let(:other_parcel) { Danica::Number.new(other) }
  let(:summed) { subject + other }

  it { expect(summed).to be_a(Danica::Sum) }
  it { expect(summed.variables).to be_include(other_parcel) }
  it { expect(summed.variables).to be_include(subject) }
end
