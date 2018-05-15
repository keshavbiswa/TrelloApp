class UserMailer < ApplicationMailer
  
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to keshav-trello.com')
  end

  def new_board_email
    @user = params[:user]
    @board = params[:board]
    mail(to: @user.email, subject: 'Created a new board')
  end
end
