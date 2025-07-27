# frozen_string_literal: true

shared_examples 'an object that respond to basic_methods' do |ignore: [], methods: %i[to_f to_tex to_gnu priority
                                                                                      valued? container? variable? variable_holder?]|
  (methods - ignore).each do |method|
    it { expect(subject).to respond_to(method) }
  end

  it 'accepts option on tex format' do
    expect do
      subject.to_tex(decimals: 2)
    end.not_to raise_error
  end

  it 'accepts option on gnu format' do
    expect do
      subject.to_gnu(decimals: 2)
    end.not_to raise_error
  end

  it 'accepts option on to format' do
    expect do
      subject.to(:gnu, decimals: 2)
    end.not_to raise_error
  end
end
