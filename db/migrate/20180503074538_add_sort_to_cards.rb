class AddSortToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :sort, :integer
  end
end
