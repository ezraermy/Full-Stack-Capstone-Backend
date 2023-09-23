class Car < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations

  validates :name, presence: true
  validates :image, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :daily_rate, presence: true, numericality: { greater_than: 0 }
  validates :car_type, presence: true
end
