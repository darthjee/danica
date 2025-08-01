# frozen_string_literal: true

shared_examples 'a operator with a single input value' do |arguments|
  subject { described_class.new(variable) }

  include_context 'when variables are initialized', arguments, 'variable_value', 'expected_number', 'expected_tex', 'expected_number_tex', 'expected_gnu', 'expected_number_gnu'

  let(:variable) { { name: 'X', value: variable_value } }

  describe '#to_f' do
    context 'when variables are not numbers but have value' do
      it 'returns the division of the values' do
        expect(subject.to_f).to eq(expected_number)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end

    context 'when the variable is a number' do
      let(:variable) { variable_value }

      it 'returns the squared root of the value' do
        expect(subject.to_f).to eq(expected_number)
      end

      it do
        expect(subject.to_f).to be_a(Float)
      end
    end
  end

  describe '#to_tex' do
    context 'when variables have no value' do
      let(:variable) { :X }

      it 'returns a latex format fraction' do
        expect(subject.to_tex).to eq(expected_tex)
      end
    end

    context 'when the variable is numeric' do
      before do
        subject.variables[0].value = variable_value
      end

      it 'prints both numbers' do
        expect(subject.to_tex).to eq(expected_number_tex)
      end
    end
  end

  describe '#to_gnu' do
    context 'when variables have no value' do
      let(:variable) { :X }

      it 'returns a latex format fraction' do
        expect(subject.to_gnu).to eq(expected_gnu)
      end
    end

    context 'when the variable is numeric' do
      before do
        subject.variables[0].value = variable_value
      end

      it 'prints both numbers' do
        expect(subject.to_gnu).to eq(expected_number_gnu)
      end
    end
  end
end
