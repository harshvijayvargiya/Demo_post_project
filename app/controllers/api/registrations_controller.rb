class Api::RegistrationsController < ApplicationController
  def show
    user = current_user
    render json: user
  end

  def create
      user =  User.new(user_params)
      if user.save
        render json: {"success": "true","data": UserSerializer.new(user)}, status: :created
      else
        render json: {"success": "false", "message": user.errors.full_messages}, status: :unprocessable_entity
      end
  end

  def update
    if current_user.update(user_params)
      render json: {"success": "true","data": UserSerializer.new(current_user)}, status: :created
    else
      render json: {"success": "false", "message": user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
      user = User.find(params[:id])
      if user.destroy
        render json: {"success": "true","data": UserSerializer.new(user)}, status: :created
      else
        render json: {"success": "false", "message": user.errors.full_messages}, status: :unprocessable_entity
      end
  end

  private

  def user_params
    params.require(:user).permit(:sign_up, keys: %i[first_name last_name contact_number profile_picture])
  end
end
