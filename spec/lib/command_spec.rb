require 'spec_helper'

RSpec.describe GraphicalEditor::Command do
  subject     { described_class.new image }
  let(:image) { nil }

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
  end

  describe '#L' do
  end

  describe '#S' do
    let(:image) { instance_double('GraphicalEditor::Image') }
    it 'sets the image' do
      allow(subject).to receive(:puts)
      expect(image).to receive(:show)
      subject.S(nil)
    end
  end

  describe '#F' do
  end

  describe '#X' do
    it { expect{ subject.X(nil) }.to raise_error SystemExit }
  end

  describe '#C' do
  end
end
