require 'spec_helper'

RSpec.describe GraphicalEditor::Image do
  subject { described_class.new(3,5) }
  let(:data) { subject.instance_variable_get(:@data) }

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
    subject.set_colour(1, 2, 'R')
    expect(data[2][1]).to eq 'R'
  end

  it 'shows the data' do
    expect { subject.show }.to output("OOO\n"*5).to_stdout
  end
end
