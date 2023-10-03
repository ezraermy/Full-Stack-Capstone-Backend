class Api::CarsController < ApplicationController
  before_action :set_reservation, only: %i[show destroy]

  def index
    cars = Car.all

    cars_json = cars.map do |car|
      {
        id: car.id,
        name: car.name,
        description: car.description,
        image: car.image,
        location: car.location,
        daily_rate: car.daily_rate,
        car_type: car.car_type
      }
    end
    render json: cars_json
  end

  def show
    if @item
      render json: @item
    else
      render json: { errors: 'Car not found' }, status: :not_found
    end
  end

  def destroy
    if @item.destroy
      # head :no_content
      render json: { message: 'Car was deleted successfully' }
    else
      render json: { errors: 'Car could not be deleted' }, status: :bad_request
    end
  end

  def create
    car = Car.new(car_params)

    if car.save
      render json: car
    else
      render json: car.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_car
    @item = Car.find_by(id: params[:id])
  end

  def car_params
    params.require(:car).permit(:name, :car_type, :description, :image, :location, :daily_rate)
  end
end
