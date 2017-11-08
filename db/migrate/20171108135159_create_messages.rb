class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.text    :message, null: false
      t.boolean :read, default: false

      t.timestamps
    end
    add_index :messages, [:sender_id, :receiver_id]
  end
end
