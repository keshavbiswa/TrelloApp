class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many  :boards

  after_create :welcome_email
  
  def welcome_email
    UserMailerWorker.perform_async(self.id)
  end

  def self.daily_update
    @user = User.all
    @user.each do |u|
      UserMailer.daily_mail(u).deliver
    end
  end
end
