class Product < ApplicationRecord
  belongs_to :user
  has_many :slots, dependent: :destroy
end
