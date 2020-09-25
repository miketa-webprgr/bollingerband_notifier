class Price < ApplicationRecord
  DEFAULT_DAYS = 10
  COEFFICIENT = 1.0

  attr_accessor :up_band, :dn_band, :sd, :avg, :too_old_flag

  belongs_to :company

  validates :company_id, uniqueness: { scope: :date }

  def upper_band(days = DEFAULT_DAYS)
    average(days) + standard_deviation(days) * COEFFICIENT
  end

  def down_band(days = DEFAULT_DAYS)
    average(days) - standard_deviation(days) * COEFFICIENT
  end

  def standard_deviation(days = DEFAULT_DAYS)
    prices = last_xdays_close_prices(days)
    average = average(days)
    variance = prices.sum { |price| (price - average)**2 } / prices.size
    Math.sqrt(variance)
  end

  def average(days = DEFAULT_DAYS)
    prices = last_xdays_close_prices(days)
    prices_sum = prices.sum
    prices_sum.to_f / prices.size
  end

  def too_old?(days = DEFAULT_DAYS)
    company.prices.where('date <= ?', date).limit(days).count < days
  end

  private

  def last_xdays_close_prices(days)
    last_xdays_price_objects(days).pluck(:close)
  end

  def last_xdays_price_objects(days)
    company.prices.where('date >= ?', date).order(date: :asc).limit(days)
  end

  # 標準偏差については、以下のサイトを参考にした
  # https://web-salad.hateblo.jp/entry/2015/02/05/110557

  # 用語の説明
  # average: 平均, variance: 分散, standard deviation: 標準偏差
  # upper_band: 平均 + 標準偏差 * 係数, lower_band: 平均 + 標準偏差 * 係数

end
