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
    let(:image) { instance_double('GraphicalEditor::Image', in?: true) }
    let(:args)  { %w(1 2 R) }

    it 'checks the arguments length' do
      expect(subject).to receive(:check_dimensions).with(args, 3)
      subject.L(args)
    end

    it 'checks the arguments are integers' do
      expect(subject).to receive(:check_integers).with(%w(1 2))
      subject.L(args)
    end

    it 'sets the image' do
      expect(image).to receive(:set_colour).with(GraphicalEditor::Cell.new(1, 2), 'R')
      subject.L(args)
    end

    it 'checks the arguments are in bounds' do
      expect(image).to receive(:in?).with(GraphicalEditor::Cell.new(1, 2)).and_return false
      subject.L(args)
    end
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
    let(:image_data) { image.instance_variable_get(:@data) }

    context 'with a blank image' do
      let(:image) { GraphicalEditor::Image.new(2, 3) }

      it 'fills in the image' do
        subject.F(%w(1 1 T))
        image_values = image_data.values.map(&:values)
        expect(image_values).to eq([%w(T T)]*3)
      end

      it 'does nothing if new colour equals existing colour' do
        subject.F(%w(1 1 O))
        image_values = image_data.values.map(&:values)
        expect(image_values).to eq([%w(O O)]*3)
      end
    end

    context 'with a complex image' do
      let(:image) { GraphicalEditor::Image.new(3, 4) }
      before do
        image.set_colour(GraphicalEditor::Cell.new(1, 1), 'R')
        image.set_colour(GraphicalEditor::Cell.new(1, 2), 'R')
        image.set_colour(GraphicalEditor::Cell.new(2, 2), 'R')
      end

      it 'fills in the colour region' do
        subject.F(%w(1 1 T))
        expect(image.get_colour(GraphicalEditor::Cell.new(1, 1))).to eq 'T'
        expect(image.get_colour(GraphicalEditor::Cell.new(1, 2))).to eq 'T'
        expect(image.get_colour(GraphicalEditor::Cell.new(2, 2))).to eq 'T'

        expect(image.get_colour(GraphicalEditor::Cell.new(2, 1))).to eq 'O'
        expect(image.get_colour(GraphicalEditor::Cell.new(1, 3))).to eq 'O'
        expect(image.get_colour(GraphicalEditor::Cell.new(2, 3))).to eq 'O'
      end
    end
  end
end
