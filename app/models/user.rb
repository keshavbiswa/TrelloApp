class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many  :boards

  after_create :welcome_email
  def welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
