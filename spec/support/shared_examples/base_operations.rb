shared_examples 'an object with basic operation' do
  it_behaves_like 'an object with + operation'
  it_behaves_like 'an object with * operation'
  it_behaves_like 'an object with / operation'
end

shared_examples 'an object with an operation' do |clazz|
  it { expect(result).to be_a(clazz) }

  it 'includes other as parcel' do
    expect(result).to be_include(other)
  end

  it 'includes the subject as parcel' do
    expect(result).to be_include(subject_included)
  end
end

shared_examples 'an object with + operation' do
  let(:other) { 104 }
  let(:result) { subject + other }
  let(:subject_included) { subject }

  it_behaves_like 'an object with an operation', Danica::Sum

  context 'when operating as reverse' do
    let(:result) { Danica::Number.new(other) + subject }
    it_behaves_like 'an object with an operation', Danica::Sum
  end
end

shared_examples 'an object with * operation' do
  let(:other) { 104 }
  let(:result) { subject * other }
  let(:subject_included) { subject }

  it_behaves_like 'an object with an operation', Danica::Product

  context 'when operating as reverse' do
    let(:result) { Danica::Number.new(other) * subject }
    it_behaves_like 'an object with an operation', Danica::Product
  end
end

shared_examples 'an object with / operation' do
  let(:other) { 104 }
  let(:other_number) { Danica::Number.new(104) }
  let(:result) { subject / other }

  it { expect(result).to be_a(Danica::Division) }

  it 'includes other as parcel' do
    expect(result.denominator).to eq(other_number)
  end

  it 'includes the subject as parcel' do
    expect(result.numerator).to eq(subject)
  end
end

