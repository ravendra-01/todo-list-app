class CreateNotification < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.string :headings
      t.string :contents
      t.boolean :is_read, default: false
      t.datetime :read_at
      t.references :account

      t.timestamps
    end
  end
end
