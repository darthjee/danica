shared_examples 'an object with + operation' do
  let(:other) { 104 }
  let(:summed) { subject + other }
  let(:subject_included) { subject }

  it { expect(summed).to be_a(Danica::Sum) }

  it 'includes other as parcel of the sum' do
    expect(summed).to be_include(other)
  end

  it 'includes the subject as parcel' do
    expect(summed).to be_include(subject_included)
  end
end
