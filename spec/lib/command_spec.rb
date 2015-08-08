require 'spec_helper'

RSpec.describe GraphicalEditor::Command do
  describe '#route' do
    %i(I C L V H F S X).each do |cmd|
      it "correctly routes #{cmd}" do
        expect(subject).to receive(:public_send).with(cmd.upcase, ['SOME', 'ARGS'])
        subject.route("#{cmd} SOME ARGS")
      end
    end

    it 'strips white space' do
      expect(subject).to receive(:public_send).with(:I, ['MORE', 'ARGS'])
      subject.route(' I  MORE   ARGS  ')
    end

    it 'upcases the line' do
      expect(subject).to receive(:public_send).with(:C, ['LOWER'])
      subject.route('c lower')
    end

    it "warns when command is unknown" do
      expect { subject.route('U') }.to output("WARNING: U not known. Must be in C, F, H, I, L, S, V, X\n").to_stdout
    end
  end

  describe '#I' do
    [%w(1 b2), %w(.9 1)].each do |dimensions|
      it 'returns warning for invalid dimensions' do
        expect { subject.I(dimensions) }.to output("ERROR: Must have non-zero numeric dimensions\n").to_stdout
      end
    end

    [%w(1 2 3), %w(1.2)].each do |dimensions|
      it 'returns warning for incorrect number of dimensions' do
        expect { subject.I(dimensions) }.to output("ERROR: Must have two dimensions\n").to_stdout
      end
    end
  end
end
