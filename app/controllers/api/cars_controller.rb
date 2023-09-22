class CarsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[destroy_car create]

  def index; end

  def list_cars
    @cars_name = Car.pluck(:id, :name, :car_type, :image)
    render json: @cars_name
  end

 
  private

  def car_params
    params.require(:car).permit(:name, :car_type, :description, :image, :location, :daily_rate)
  end
end
