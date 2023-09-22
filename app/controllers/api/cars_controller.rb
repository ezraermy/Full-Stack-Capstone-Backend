class CarsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[destroy_car create]

  def index; end

  def list_cars
    @cars_name = Car.pluck(:id, :name, :car_type, :image)
    render json: @cars_name
  end

  def list_cars_details
    @item = Car.find_by(id: params[:id])
    render json: @item
  end

  def destroy_car
    @item = Car.find_by(id: params[:id])
    @item.destroy
    head :no_content
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
