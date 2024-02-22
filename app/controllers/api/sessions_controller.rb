class Api::SessionsController < Api::ApiController
  def create
    @user = User.find_for_database_authentication(email: params[:email])

    if @user && @user.valid_password?(params[:password])
      token = @user.create_new_auth_token
      render json: { user: @user, token: token['Authorization'] }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
