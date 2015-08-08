require 'spec_helper'

RSpec.describe GraphicalEditor::Image do
  subject { described_class.new(3,5) }
  let(:data) { subject.instance_variable_get(:@data) }
  let(:cell) { GraphicalEditor::Cell.new(1, 2) }

  it 'sets data as a hash' do
    expect(data).to be_a Hash
    expect(data[1]).to be_a Hash
  end

  it 'sets the correct dimensions of the data' do
    expect(data.size).to eq 5
    expect(data[1].size).to eq 3
  end

  it 'sets the colours initial data colours' do
    expect(data[1][2]).to eq 'O'
  end

  it 'sets the colours of the data' do
    subject.set_colour(cell, 'R')
    expect(data[2][1]).to eq 'R'
  end

  it 'gets the colour of the data' do
    expect(subject.get_colour(cell)).to eq 'O'
    subject.set_colour(cell, 'R')
    expect(subject.get_colour(cell)).to eq 'R'
  end

  it 'shows the data' do
    expect { subject.show }.to output("OOO\n"*5).to_stdout
  end

  describe '#in?' do
    [[1,1], [3,5]].each do |dimensions|
      it 'returns true if in image' do
        expect(subject.in?(GraphicalEditor::Cell.new(*dimensions))).to be true
      end
    end

    [[3,6], [4,5], [1,0], [0,1]].each do |dimensions|
      it 'returns false if greater in image' do
        expect(subject.in?(GraphicalEditor::Cell.new(*dimensions))).to be false
      end
    end
  end
end
