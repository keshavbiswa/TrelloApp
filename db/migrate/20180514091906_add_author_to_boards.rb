class AddAuthorToBoards < ActiveRecord::Migration[5.2]
  def change
    add_column :boards, :author, :string
  end
end
