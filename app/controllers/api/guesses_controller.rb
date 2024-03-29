require_relative '../../services/game_logic_service'

class Api::GuessesController < Api::ApiController
  before_action :authenticate_user!
  before_action :set_game, only: [:create]

  def index
    @guesses = Guess.all
    render json: { guess: GuessSerializer.new(@guesses) }
  end

  def show
    @guess = Guess.find_by(id: params[:id])
    if @guess.present?
      render json: { guess: GuessSerializer.new(@guesses) }
    else
      render json: { }, status: :not_found
    end
  end

  def create
    if @guess.save
      message = @game.check_winner(current_user, @guess)
      render_success_response(message)
    else
      render_error_response(@guess.errors)
    end
  end

  private

  def set_game
    @guess = build_guess
    @game = GameLogicService.new
  end

  def build_guess
    guess = Guess.new(guess_params)
    guess.user_id = current_user.id
    guess
  end

  def render_success_response(message)
    render json: { guess: GuessSerializer.new(@guess), message: message }, status: :created
  end

  def render_error_response(errors, status = :unprocessable_entity)
    render json: { errors: errors }, status: status
  end

  def guess_params
    params.require(:guess).permit(:latitude, :longitude)
  end
end
