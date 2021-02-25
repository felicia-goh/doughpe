class Order < ApplicationRecord
  belongs_to :user
  belongs_to :slot
  has_one :review, dependent: :destroy
  has_one :purchase

  validates :delivery_address, presence: true
  validates :delivery_method, presence: true, inclusion: { in: %w[self-collection delivery] }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
