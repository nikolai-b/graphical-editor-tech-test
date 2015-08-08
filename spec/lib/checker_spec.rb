require 'spec_helper'

RSpec.describe GraphicalEditor::Checker do
  subject { (Class.new { include GraphicalEditor::Checker }).new }

  describe '#check_integers' do
    [%w(1 b2), %w(3 .9 1), %w(9 10 83 a97)].each do |dimensions|
      it 'returns warning for non integer dimensions' do
        expect { subject.check_integers(dimensions) }.to output("ERROR: Must have non-zero, numeric dimensions\n").to_stdout
      end

      it 'returns false for non integer dimensions' do
        allow(subject).to receive(:puts)
        expect(subject.check_integers(dimensions)).to be_falsey
      end
    end

    it 'return the integers strings as integers if valid' do
      expect( subject.check_integers(%w(1 2 3)) ).to eq([1, 2, 3])
    end
  end

  describe '#check_integers' do
    context 'for invalid input' do
      it 'returns warning for incorrect number of dimensions' do
        expect { subject.check_dimensions([0], 2) }.to output(/must have 2 arguments/).to_stdout
      end

      it 'has the calling methods name' do
        expect { subject.check_dimensions([0], 2) }.to output(/ERROR: Command block/).to_stdout
      end

      it 'returns false' do
        allow(subject).to receive(:puts)
        expect(subject.check_dimensions([0], 2)).to be_falsey
      end
    end

    it 'returns true for valid input' do
      expect(subject.check_dimensions([0, 3], 2)).to eq true
    end
  end
end
