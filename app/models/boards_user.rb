class BoardsUser < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validate_uniqueness_of :users
  validate_uniqueness_of :boards
end
