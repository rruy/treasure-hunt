class GuessesController < ApplicationController

  def create
    @guess = Guess.new(guess_params)
    distance = GameLogicService.new.calculate_distance(@guess.latitude, @guess.longitude)

    if distance < 1000
      if !current_user.winner?
        current_user.update(winner: true)
        UserMailer.with(user: current_user).winner_confirmation_email.deliver_now
      end
    end

    respond_to do |format|
      if @guess.save
        format.html { redirect_to @guess, notice: 'Guess was successfully created.' }
        format.json { render :show, status: :created, location: @guess }
      else
        format.html { render :new }
        format.json { render json: @guess.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def guess_params
    params.require(:guess).permit(:latitude, :longitude)
  end
end
