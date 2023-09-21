# app/models/reservation.rb
class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car

  # Validations
  validates_presence_of :reservation_date, :due_date, :service_fee
  validate :reservation_date_cannot_be_in_the_past
  validate :due_date_must_be_after_reservation_date

  private

  def reservation_date_cannot_be_in_the_past
    if reservation_date.present? && reservation_date < Date.today
      errors.add(:reservation_date, "can't be in the past")
    end
  end

  def due_date_must_be_after_reservation_date
    if reservation_date.present? && due_date.present? && due_date <= reservation_date
      errors.add(:due_date, "must be after the reservation date")
    end
  end
end
