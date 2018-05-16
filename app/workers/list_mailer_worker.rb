class ListMailerWorker
  include Sidekiq::Worker

  def perform(user_id, list_id)
    user = User.find(user_id)
    list = List.find(list_id)
    UserMailer.with(user: user, list: list).new_list_email.deliver
  end
  
end