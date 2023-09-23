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

  it 'Verifies daily rate is numeric' do
    expect(subject.daily_rate).to be_a_kind_of(Numeric)
  end

  it 'Verifies daily rate is greater than 0' do
    expect(subject.daily_rate).to be > 0
  end
  it 'Verifies image is a string' do
    expect(subject.image).to be_a_kind_of(String)
  end

  it 'Verifies name is a string' do
    expect(subject.name).to be_a_kind_of(String)
  end

  it 'Verifies car type is a string' do
    expect(subject.car_type).to be_a_kind_of(String)
  end

  it 'Verifies description is a Numberic' do
    expect(subject.description).to be_a_kind_of(String)
  end

  it 'Verifies location is a string' do
    expect(subject.location).to be_a_kind_of(String)
  end

  it 'Verifies daily rate is a numeric' do
    expect(subject.daily_rate).to be_a_kind_of(Numeric)
  end
end
