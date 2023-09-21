class Api::ReservationsController < ApplicationController
      before_action :set_reservation, only: %i[show update destroy]
      skip_before_action :verify_authenticity_token, only: %i[destroy create]
  
      # This action handles the HTTP GET request to retrieve a list of reservations.
      def index
        @reservations = Reservation.includes(:car).all
        reservations_json = @reservations.map do |reservation|
          car = Car.find(reservation.car_id)
          {
            id: reservation.id,
            reservation_date: reservation.reservation_date,
            due_date: reservation.due_date,
            service_fee: reservation.service_fee,
            car_name: car.name,
            car_photo: car.photo
          }
        end
        render json: reservations_json
      end

      # This action handles the HTTP POST request to create a new reservation
      def create
        @user = User.find_by(username: params[:username])
        @reservation = @user.reservations.build(reservation_params)
        if @reservation.save
          render json: @reservation, status: :created
        else
          render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      # This action handles the HTTP GET request to retrieve details of a specific reservation
      def show
        render json: reservation_details_json(@reservation)
      end
  
      # This action handles the HTTP PUT request to update an existing reservation
      def update
        if @reservation.update(reservation_params)
          render json: reservation_details_json(@reservation), status: :ok
        else
          render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      # DELETE /api/reservations/:id
      def destroy
        @reservation.destroy
        head :no_content
      end
  
      private
  
      # Use callbacks to share common setup or constraints between actions.
      def set_reservation
        @reservation = Reservation.find(params[:id])
      end
  
      # Only allow a list of specific parameters for create and update actions.
      def reservation_params
        params.require(:reservation).permit(:username, :reservation_date, :due_date, :service_fee, :car_id)
      end
    end
  end
  