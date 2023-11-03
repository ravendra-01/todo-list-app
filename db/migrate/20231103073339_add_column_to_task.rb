class AddColumnToTask < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :planned_date, :datetime
    add_column :tasks, :priority, :integer
  end
end
