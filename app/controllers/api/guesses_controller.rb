require_relative '../../services/game_logic_service'

class Api::GuessesController < Api::ApiController
  before_action :authenticate_user!

  def create
    message = ''
    @guess = Guess.new(guess_params)
    @guess.user_id = current_user.id

    distance = GameLogicService.new.calculate_distance(@guess.latitude, @guess.longitude)

    if distance.to_i < 1000
      if !current_user.winner?
        current_user.update(winner: true)
        message = "User #{current_user.email} is new Winner!"
        send_email
      else
        message = "User #{current_user.email} has already Won!"
      end
    end

    if @guess.save
      render json: { guess: @guess, message: message }, status: :created
    else
      render json: @guess.errors, status: :unprocessable_entity
    end
  end

  private

  def send_email
    begin
      UserMailer.with(user: current_user).winner_confirmation_email.deliver_now
    rescue => e
      logger.info "Error when processing User mailer #{current_user.email}"
    end
  end

  def guess_params
    params.require(:guess).permit(:latitude, :longitude)
  end
end
