class Api::UsersController < Api::ApiController
  before_action :authenticate_user!
  before_action :set_user, only: %w[show update destroy]

  def index
    @users = User.all
    render json: { users: UserSerializer.new(@users) }
  end

  def show
    render json: UserSerializer.new(@user)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: UserSerializer.new(@user), status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :winner)
  end
end
