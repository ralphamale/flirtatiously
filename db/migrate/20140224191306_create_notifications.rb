class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :receiver_id
      t.integer :trigger_id
      t.integer :type
      t.boolean :is_read

      t.timestamps
    end

    add_index :notifications, :receiver_id
  end
end
