class Slot < ApplicationRecord
  belongs_to :product
  has_many :orders, dependent: :destroy
  validates :available_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :time_period, inclusion: { in: %w[morning afternoon evening unselected] }
end
