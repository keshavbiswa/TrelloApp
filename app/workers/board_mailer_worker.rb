class BoardMailerWorker
  include Sidekiq::Worker

  def perform(user_id, board_id)
    user = User.find(user_id)
    board = Board.find(board_id)
    UserMailer.with(user: user, board: board).new_board_email.deliver
  end
  
end