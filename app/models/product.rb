class Product < ApplicationRecord
  belongs_to :user
  has_many :slots, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
  has_one_attached :photo

  def selected_dates
    slots.map do |slot|
      slot.date
    end
  end
end
