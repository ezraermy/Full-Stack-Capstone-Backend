require 'rails_helper'

RSpec.describe Reservation, type: :model do
  subject do
    Reservation.new(
      reservation_date: '2021-10-10',
      due_date: '2021-10-15',
      service_fee: 100,
      car_id: 1
    )
  end
  before { subject.save }

  it 'Verifies reservation_date is not blank' do
    subject.reservation_date = nil
    expect(subject).to_not be_valid
  end

  it 'Verifies due_date is not blank' do
    subject.due_date = nil
    expect(subject).to_not be_valid
  end

  it 'Verifies service_fee is not blank' do
    subject.service_fee = nil
    expect(subject).to_not be_valid
  end

  it 'Verifies car_id is not blank' do
    subject.car_id = nil
    expect(subject).to_not be_valid
  end
end
