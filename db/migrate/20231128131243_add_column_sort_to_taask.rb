class AddColumnSortToTaask < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :sort, :integer
  end
end
