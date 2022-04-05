require 'rspec/autorun'

RSpec.describe 'TaskOne' do
  let(:task) { TaskOne.new(['BTT', 'AXS']) }
  let(:result) { task.run }

  before do
    allow(NomicsClient).to receive(:new).and_return(double(get: [
      {
        'id' => 'BTT',
        'status' => 'active',
        'price' => '0.0041642670'
      },
      {
        'id' => 'AXS',
        'status' => 'dead',
        'price' => '0.000069194533'
      }
    ]))
  end

  it 'returns full payload, given tickers' do
    expect(result).to be_a(Array)
    expect(result).to have_attributes(size: 2)

    expect(result.dig(0, 'id')).to eq('BTT')
    expect(result.dig(1, 'id')).to eq('AXS')
  end
end

RSpec.describe 'TaskTwo' do
  let(:task) { TaskTwo.new(['BTT', 'AXS'], ['id', 'status']) }
  let(:result) { task.run }

  before do
    allow(NomicsClient).to receive(:new).and_return(double(get: [
      {
        'id' => 'BTT',
        'status' => 'active',
        'price' => '0.0041642670'
      },
      {
        'id' => 'AXS',
        'status' => 'dead',
        'price' => '0.000069194533'
      }
    ]))
  end

  it 'returns selected payload, given tickers' do
    expect(result).to eq([
      {
        'id' => 'BTT',
        'status' => 'active'
      },
      {
        'id' => 'AXS',
        'status' => 'dead'
      }
    ])
  end
end
