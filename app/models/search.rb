class Search < ApplicationRecord
  belongs_to :company

  validates :sigma, presence: true, numericality: { greater_than_or_equal_to: 1.0, less_than_or_equal_to: 3.0 }
  validates :mv_period, presence: true, numericality: { greater_than_or_equal_to: 10, less_than_or_equal_to: 30 }
end
