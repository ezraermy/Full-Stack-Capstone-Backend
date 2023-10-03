class Api::UsersController < ApplicationController
  def index
    @user = User.find_by(user_name: params[:user_name])
    if @user
      render json: @user
    else
      render json: { errors: "User doesn't exist" }, status: :not_found
    end
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      render json: new_user
    else
      render json: { errors: new_user.errors.full_messages }, status: :bad_request
    end
  end

  def user_params
    params.require(:user).permit(:name, :user_name)
  end
end
