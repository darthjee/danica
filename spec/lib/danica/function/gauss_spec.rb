require 'spec_helper'

describe Danica::Function::Gauss do
  let(:variables) do
    {
      x: :x,
      median: :u,
      variance_root: { latex: '\theta', gnu: :v }
    }
  end

  subject { described_class::Gauss.new(variables) }
  it_behaves_like 'an object that respond to basic_methods'

  describe '#to_tex' do
    context 'when creating the spatial operator for constantly accelerated movement' do
      let(:expected) { '\frac{1}{\sqrt{2 \cdot \pi \cdot \theta^{2}}} \cdot e^{-\frac{\left(x -u\right)^{2}}{2 \cdot \theta^{2}}}'  }

      it 'return the latex format CAM' do
        expect(subject.to_tex).to eq(expected)
      end
    end
  end

  describe '#to_gnu' do
    context 'when creating the spatial operator for constantly accelerated movement' do
      let(:expected) { '(1)/(sqrt(2 * pi * v**(2))) * exp(-((x -u)**(2))/(2 * v**(2)))' }

      it 'return the gnu format CAM' do
        expect(subject.to_gnu).to eq(expected)
      end
    end
  end

  context 'when not passing variables' do
    subject { described_class::Gauss.new }

    describe '#to_tex' do
      let(:expected) { '\frac{1}{\sqrt{2 \cdot \pi \cdot \theta^{2}}} \cdot e^{-\frac{\left(x -u\right)^{2}}{2 \cdot \theta^{2}}}'  }

      it 'rely on default variables definition' do
        expect(subject.to_tex).to eq(expected)
      end
    end

    describe '#to_gnu' do
      let(:expected) { '(1)/(sqrt(2 * pi * v**(2))) * exp(-((x -u)**(2))/(2 * v**(2)))' }

      it 'rely on default variables definition' do
        expect(subject.to_gnu).to eq(expected)
      end
    end
  end
end
