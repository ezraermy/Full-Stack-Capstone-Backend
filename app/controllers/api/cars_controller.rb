class Api::CarsController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: %i[destroy_car create]

  def index
    @cars = Car.all

    @cars_json = @cars.map do |car|
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
    render json: @cars_json
  end

  def show
    @item = Car.find_by(id: params[:id])
    if @item
      render json: @item
    else
      render json: { errors: 'Car not found' }
    end
  end

  def destroy
    @item = Car.find_by(id: params[:id])
    if @item.destroy
      # head :no_content
      render json: { message: 'Car was deleted successfully' }
    else
      render json: { errors: 'Car could not be deleted' }
    end
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      render json: @car
    else
      render json: @car.errors.full_messages
    end
  end

  private

  def car_params
    params.require(:car).permit(:name, :car_type, :description, :image, :location, :daily_rate)
  end
end
