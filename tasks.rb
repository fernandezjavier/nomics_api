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

class TaskThree
  attr_reader :currency, :reference_fiat

  def initialize(currency:, reference_fiat:)
    @currency = currency
    @reference_fiat = reference_fiat
  end

  def run
    query_params = {
      ids: currency,
      'quote-currency': reference_fiat
    }

    NomicsClient
      .new('currencies/ticker', query_params)
      .get
      .dig(0, 'price')
      .to_f
  end
end