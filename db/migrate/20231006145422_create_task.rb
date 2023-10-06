class CreateTask < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.bigint :account_id

      t.timestamps
    end
  end
end
