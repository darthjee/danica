shared_examples 'an object with basic operation' do |operations:%i(+ - * /), ignore:[]|
  (operations - [ ignore ].flatten).each do |operation|
    it_behaves_like "an object with #{operation} operation"
  end
end

shared_examples 'an object with an operation' do |clazz|
  it { expect(result).to be_a(clazz) }

  it 'includes other as parcel' do
    expect(result).to include(other)
  end

  it 'includes the subject as parcel' do
    expect(result).to include(subject_included)
  end
end

shared_examples 'an object with + operation' do
  let(:other) { 104 }
  let(:result) { subject + other }
  let(:subject_included) { subject }

  it_behaves_like 'an object with an operation', Danica::Operator::Addition

  context 'when operating as reverse' do
    let(:result) { Danica::Wrapper::Number.new(other) + subject }
    it_behaves_like 'an object with an operation', Danica::Operator::Addition
  end
end

shared_examples 'an object with * operation' do
  let(:other) { 104 }
  let(:result) { subject * other }
  let(:subject_included) { subject }

  it_behaves_like 'an object with an operation', Danica::Operator::Multiplication

  context 'when operating as reverse' do
    let(:result) { Danica::Wrapper::Number.new(other) * subject }
    it_behaves_like 'an object with an operation', Danica::Operator::Multiplication
  end
end

shared_examples 'an object with / operation' do
  let(:other) { 104 }
  let(:other_number) { Danica::Wrapper::Number.new(104) }
  let(:result) { subject / other }

  it { expect(result).to be_a(Danica::Operator::Division) }

  it 'includes other as denominator' do
    expect(result.denominator).to eq(other_number)
  end

  it 'includes the subject as numerator' do
    expect(result.numerator).to eq(subject)
  end
end

shared_examples 'an object with - operation' do
  let(:other) { 104 }
  let(:negative_other) { Danica::Wrapper::Negative.new(other) }
  let(:result) { subject - other }
  let(:subject_included) { subject }

  it { expect(result).to be_a(Danica::Operator::Addition) }

  it 'includes other as negative parcel' do
    expect(result).to include(negative_other)
  end

  it 'includes the subject as parcel' do
    expect(result).to include(subject_included)
  end
end

