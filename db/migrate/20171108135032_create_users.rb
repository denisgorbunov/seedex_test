class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :nickname, null: false
      t.datetime :last_online_at, null: false

      t.timestamps
    end
    add_index :users, :nickname, unique: true
  end
end
