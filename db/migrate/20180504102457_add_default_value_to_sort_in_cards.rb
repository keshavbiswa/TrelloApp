class AddDefaultValueToSortInCards < ActiveRecord::Migration[5.2]
  def change
    change_column :cards, :sort, :integer, default: 0
  end
end
