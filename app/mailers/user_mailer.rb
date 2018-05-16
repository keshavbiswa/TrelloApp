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

  def new_list_email
    @user = params[:user]
    @list = params[:list]
    mail(to: @user.email, subject: 'Created a new list')
  end

  def daily_mail(user)
    @user = user
    mail(to: @user.email, subject: "Daily report of keshav-trello.com")
  end

  def new_member_mail
    @user = params[:user]
    @board = params[:board]
    mail(to: @user.email, subject: 'Welcome')
  end
end
