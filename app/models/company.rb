class Company < ApplicationRecord
  has_many :prices, dependent: :destroy
  has_many :searches, dependent: :destroy

  after_create_commit :fetch_stock_api

  def fetch_stock_api
    require 'uri'

    url = URI("https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v3/get-historical-data?region=US&symbol=#{symbol}")  
    prices_array = JSON.parse(json_response(url))["prices"]

    prices_array.each do |hash|
      date = Time.zone.at(hash["date"])
      close = hash['close']
      high = hash['high']
      low = hash['low']
      volume = hash['volume']
      price_record = self.prices.build(date: date, close: close, high: high, low: low, volume: volume)
      if price_record.save
        logger.debug "#{price_record.company.name}のレコードを作成（id: #{price_record.id}）#{price_record.date.in_time_zone("America/New_York")} "
      else
        logger.debug puts "保存できず： #{hash}"
      end
    end
  end

  def json_response(url)
    require 'net/http'
    require 'openssl'

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-host'] = 'apidojo-yahoo-finance-v1.p.rapidapi.com'
    request['x-rapidapi-key'] = '66d827ac3cmsh41845e2a2a01c44p114383jsnc726848c4b5d'
    http.request(request).read_body #=> json_responseが返り値になる
  end
end
