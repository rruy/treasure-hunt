class AddGuessedToGuess < ActiveRecord::Migration[7.0]
  def change
    add_column :guesses, :guessed, :boolean
  end
end
