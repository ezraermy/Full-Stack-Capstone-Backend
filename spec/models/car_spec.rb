require 'rails_helper'

RSpec.describe Car, type: :model do
  subject do
    Car.new(
      name: 'Toyota',
      car_type: 'Camry',
      description: ' Sedan with 3000cc 110hp engine, automatic transmission.',
      image: 'https://www.imageapi.com/1/1/1',
      location: 'Addis Ababa',
      daily_rate: 100
    )
  end
  before { subject.save }

  it 'Verifies name is not blank' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Verifies car type is not blank' do
    subject.car_type = nil
    expect(subject).to_not be_valid
  end

  it 'Verifies description is not blank' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it 'Verifies location is not blank' do
    subject.location = nil
    expect(subject).to_not be_valid
  end

  it 'Verifies daily rate is not blank' do
    subject.daily_rate = nil
    expect(subject).to_not be_valid
  end

  it 'Verifies image is not blank' do
    subject.image = nil
    expect(subject).to_not be_valid
  end
end
