class Board < ApplicationRecord
  has_and_belongs_to_many :users
  enum scope: {Public: 0, Private: 1}
end
