class CreateMessageHeaders < ActiveRecord::Migration
  def change
    create_table :message_headers do |t|
      t.integer :user_id
      t.integer :other_id
      t.integer :message_id
      t.boolean :is_sent
      t.boolean :is_read, default: false

      t.timestamps
    end

    add_index :message_headers, :user_id
    add_index :message_headers, :other_id
    add_index :message_headers, :message_id
  end
end
