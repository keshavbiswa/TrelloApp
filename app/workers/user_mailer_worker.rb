class UserMailerWorker
  include Sidekiq::Worker

  def perform(id)
    user = User.find(id)
    UserMailer.welcome_email(user).deliver
  end
  
end
