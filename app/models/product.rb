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

  include PgSearch::Model
  pg_search_scope :search_name_and_desc,
    against: [ :name, :description ],
    using: {
      tsearch: { prefix: true }
    }
end
