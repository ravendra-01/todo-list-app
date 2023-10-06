class CreateAccount < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.bigint :phone_number
      t.string :email
      t.boolean :activated, :null => false, :default => false
      t.string :password_digest

      t.timestamps
    end
  end
end
