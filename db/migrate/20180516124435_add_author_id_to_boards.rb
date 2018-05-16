class AddAuthorIdToBoards < ActiveRecord::Migration[5.2]
  def change
    remove_column :boards, :author, :string
    add_column :boards, :author_id, :bigint
  end
end
