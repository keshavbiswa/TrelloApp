class ChangeSortInCards < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :sort
    add_column :cards, :sort, :float, default: 0.0
  end
end
