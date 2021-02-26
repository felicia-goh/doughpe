class Slot < ApplicationRecord
  belongs_to :product
  has_many :orders, dependent: :destroy
  validates :available_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

end
