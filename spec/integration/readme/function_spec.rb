require 'spec_helper'

describe Danica::Function::Spatial do
  subject do
    described_class.new(
      time: :t,
      acceleration: 'a',
      initial_space: { name: :S0, latex: 'S_0', gnu: 'S0' },
      initial_velocity: { name: :V0, latex: 'V_0', gnu: 'V0' }
    )
  end

  let(:name) { :f }

  context 'when using it as default' do
    let(:left) { "#{name}(time, acceleration, initial_space, initial_velocity)" }
    let(:right) { 'initial_space + initial_velocity * time + (acceleration * time**(2))/(2)' }

    subject { described_class.new }

    it 'knows how to return to gnu format' do
      expect(subject.to_gnu).to eq("#{left} = #{right}")
    end

    context 'when changing the name' do
      let(:name) { :g }
      subject { described_class.new(name: name) }

      it 'knows how to return to gnu format' do
        expect(subject.to_gnu).to eq("#{left} = #{right}")
      end
    end
  end

  context 'when setting the variables' do
    let(:variables) do
      { time: :t, acceleration: :a, initial_space: :s0, initial_velocity: :v0 }
    end
    let(:left) { "#{name}(t, a, s0, v0)" }
    let(:right) { 's0 + v0 * t + (a * t**(2))/(2)' }

    subject { described_class.new(variables) }

    it 'knows how to return to gnu format' do
      expect(subject.to_gnu).to eq("#{left} = #{right}")
    end
  end

  describe '#to_tex' do
    let(:left) { "#{name}(t, a, S_0, V_0)" }
    let(:right) { 'S_0 + V_0 \cdot t + \frac{a \cdot t^{2}}{2}' }

    it 'builds tex format with its variables' do
      expect(subject.to_tex).to eq("#{left} = #{right}")
    end
  end

  describe '#to_gnu' do
    let(:left) { "#{name}(t, a, S0, V0)" }
    let(:right) { 'S0 + V0 * t + (a * t**(2))/(2)' }

    it 'builds gnu format with its variables' do
      expect(subject.to_gnu).to eq("#{left} = #{right}")
    end
  end
end

describe Danica::Function::MyFunction do
  describe '#to_gnu' do
    it 'returns the function' do
      expect(subject.to_gnu).to eq('f(x, y) = x**(2) + y')
    end
  end
end

describe Danica::Function::QuadraticSum do
  describe '#to_tex' do
    it 'creates a funcion out of an expression' do
      expect(subject.to_tex).to eq("f(x, y) = \\left(x + y\\right)^{2}")
    end
  end
end
