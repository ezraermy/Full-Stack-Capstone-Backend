class Api::ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show update destroy]

  # HTTP GET request to retrieve a list of reservations.
  def index
    @reservations = User.find_by(id: params[:user_id]).reservations.includes(:car)
    reservations_json = @reservations.map do |reservation|
      {
        id: reservation.id,
        user_id: reservation.user_id,
        reservation_date: reservation.reservation_date,
        due_date: reservation.due_date,
        service_fee: reservation.service_fee,
        car: reservation.car
      }
    end
    render json: reservations_json
  end

  # HTTP POST request to create a new reservation
  def create
    @user = User.find_by(id: params[:user_id])
    @reservation = @user.reservations.build(reservation_params)
    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # HTTP GET request to retrieve details of a specific reservation
  def show
    render json:

    {
      id: @reservation.id,
      user_id: @reservation.user_id,
      reservation_date: @reservation.reservation_date,
      due_date: @reservation.due_date,
      service_fee: @reservation.service_fee,
      car: @reservation.car
    }
  end

  # DELETE /api/reservations/:id
  def destroy
    if @reservation.destroy
      render json: { message: 'Reservation was deleted successfully' }
    else
      render json: { errors: 'Reservation could not be deleted' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of specific parameters for create and update actions.
  def reservation_params
    params.require(:reservation).permit(:reservation_date, :due_date, :service_fee, :car_id)
  end
end
