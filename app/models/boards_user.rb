class BoardsUser < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validate_uniqueness_of :user
  validate_uniqueness_of :board
end
