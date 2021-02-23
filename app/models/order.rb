class Order < ApplicationRecord
  belongs_to :user
  belongs_to :slot
  has_one :review
  has_one :purchase
end
