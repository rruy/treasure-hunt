class Api::WinnersController < Api::ApiController
  before_action :authenticate_user!

  def index
    winners = User.where(winner: true)
                   .order(distance: :asc)
                   .page(params[:page]).per(params[:per_page])

    render json: UserSerializer.new(winners)
  end
end
