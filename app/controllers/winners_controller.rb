class WinnersController < ApplicationController
  def index
    @winners = User.where(winner: true).order(distance: :asc).paginate(page: params[:page], per_page: 10)
    render json: @winners
  end
end
