class Api::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token

  def sign_up
    @user = User.new(user_params)

    if @user.save
      render json: { user: @user, token: @user.authentication_token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def sign_in
    @user = User.find_for_database_authentication(email: params[:email])

    if @user && @user.valid_password?(params[:password])
      token = @user.create_new_auth_token
      render json: { user: @user, token: token['Authorization'] }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
