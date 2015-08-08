require 'spec_helper'

RSpec.describe GraphicalEditor::Image do
  subject { described_class.new(3,5) }
  let(:data) { subject.instance_variable_get(:@data) }

  it 'sets data as a hash' do
    expect(data).to be_a Hash
    expect(data[1]).to be_a Hash
  end

  it 'sets the correct dimensions of the data' do
    expect(data.size).to eq 3
    expect(data[1].size).to eq 5
  end
end
