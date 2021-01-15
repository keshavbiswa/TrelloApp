class BoardsUser < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates_uniqueness_of :user
  validates_uniqueness_of :board
end
