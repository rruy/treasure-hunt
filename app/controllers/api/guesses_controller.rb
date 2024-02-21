class Api::GuessesController < Api::ApiController
  before_action :authenticate_user!

  def create
    @guess = Guess.new(guess_params)
    distance = GameLogicService.new.calculate_distance(@guess.latitude, @guess.longitude)

    if distance < 1000
      if !current_user.winner?
        current_user.update(winner: true)
        UserMailer.with(user: current_user).winner_confirmation_email.deliver_now
      end
    end

    if @guess.save
      render json: @guess, status: :created
    else
      render json: @guess.errors, status: :unprocessable_entity
    end
  end

  private

  def guess_params
    params.require(:guess).permit(:latitude, :longitude)
  end
end
