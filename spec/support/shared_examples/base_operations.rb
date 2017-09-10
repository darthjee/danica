shared_examples 'an object with basic operation' do
  it_behaves_like 'an object with + operation'
  it_behaves_like 'an object with * operation'
end

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

shared_examples 'an object with * operation' do
  let(:other) { 104 }
  let(:product) { subject * other }
  let(:subject_included) { subject }

  it { expect(product).to be_a(Danica::Product) }

  it 'includes other as parcel of the sum' do
    expect(product).to be_include(other)
  end

  it 'includes the subject as parcel' do
    expect(product).to be_include(subject_included)
  end
end
