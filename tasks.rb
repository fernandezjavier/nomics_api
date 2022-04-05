require './lib/nomics_client'

class TaskOne
  attr_reader :tickers

  def initialize(tickers = [])
    @tickers = tickers
  end

  def run
    NomicsClient
      .new('currencies/ticker', ids: tickers.join(','))
      .get
  end
end

class TaskTwo
  attr_reader :tickers, :fields

  def initialize(tickers = [], fields = [])
    @tickers = tickers
    @fields = fields
  end

  def run
    NomicsClient
      .new('currencies/ticker', ids: tickers.join(','))
      .get
      .map { |crypto| crypto.slice(*fields) }
  end
end
