class Price < ApplicationRecord
  attr_accessor :up_band, :dn_band, :sd, :avg, :too_old_flag

  belongs_to :company

  validates :company_id, uniqueness: { scope: :date }

  def upper_band(days = company.search.mv_period)
    average_price(days) + standard_deviation(days) * company.search.sigma
  end

  def down_band(days = company.search.mv_period)
    average_price(days) - standard_deviation(days) * company.search.sigma
  end

  def standard_deviation(days = company.search.mv_period)
    prices = last_xdays_close_prices(days)
    average_price = average_price(days)
    variance = prices.sum { |price| (price - average_price)**2 } / prices.size
    Math.sqrt(variance)
  end

  def average_price(days = company.search.mv_period)
    prices = last_xdays_close_prices(days)
    prices_sum = prices.sum
    prices_sum.to_f / prices.size
  end

  def too_old?(days = company.search.mv_period)
    @last_prices.size < days
  end

  private

  def last_xdays_close_prices(days)
    @last_prices = company.prices.where('date <= ?', date).order(date: :desc).limit(days).pluck(:close)
  end

  # 標準偏差については、以下のサイトを参考にした
  # https://web-salad.hateblo.jp/entry/2015/02/05/110557

  # 用語の説明
  # average: 平均, variance: 分散, standard deviation: 標準偏差
  # upper_band: 平均 + 標準偏差 * 係数, lower_band: 平均 + 標準偏差 * 係数

end
