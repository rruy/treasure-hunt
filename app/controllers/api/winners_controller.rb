class Api::WinnersController < Api::ApiController
  before_action :authenticate_user!

  def index
    winners = User.where(winner: true)
                  .order("#{sort_column} #{sort_direction}")
                  .page(params[:page]).per(params[:per_page])

    render json: UserSerializer.new(winners)
  end

  private

  def sort_column
    %w[distance].include?(params[:sort]) ? params[:sort] : 'distance'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
