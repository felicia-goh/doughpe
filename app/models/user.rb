class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  has_many :slots, through: :products
  has_many :orders, through: :slots
  has_many :reviews, through: :orders
<<<<<<< HEAD
=======
  validates :username, presence: true, uniqueness: true
>>>>>>> 749231897706b1f38fac635687a1d0775a4e8f20
  has_one_attached :photo
end
