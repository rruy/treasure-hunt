class Api::WinnersController < Api::ApiController
  before_action :authenticate_user!

  def index
    winners = User.where(winner: true)
                  .order("distance #{sort_distance}")
                  .page(page_param).per(10)

    render json: UserSerializer.new(winners)
  end

  private

  def sort_distance
    %w[asc desc].include?(params[:sort_distance]) ? params[:sort_distance] : 'asc'
  end
end
