class Board < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :lists, dependent: :destroy
  
  enum scope: {Public: 0, Private: 1}
end
