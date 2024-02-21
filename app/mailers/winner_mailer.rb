class UserMailer < ApplicationMailer
  def winner_confirmation_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Congratulations! You are a winner!')
  end
end
