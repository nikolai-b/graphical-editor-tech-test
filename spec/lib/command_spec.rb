require 'spec_helper'

RSpec.describe GraphicalEditor::Command do
  subject { described_class.new nil }

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
    let(:args) { %w(1 2) }
    it 'checks the arguments length' do
      expect(subject).to receive(:check_dimensions).with(args, 2)
      subject.I(args)
    end

    it 'checks the arguments are integers' do
      expect(subject).to receive(:check_integers).with(args)
      subject.I(args)
    end

    it 'sets the image' do
      expect(subject.instance_variable_get(:@image)).to be_nil
      subject.I(args)
      expect(subject.instance_variable_get(:@image)).to be_a GraphicalEditor::Image
    end
  end

  describe '#L' do
    let(:args)         { %w(1 2 R) }
    it 'checks the arguments length' do
      expect(subject).to receive(:check_dimensions).with(args, 3)
      subject.L(args)
    end

    it 'checks the arguments are integers' do
      expect(subject).to receive(:check_integers).with(%w(1 2))
      subject.L(args)
    end
  end

end
