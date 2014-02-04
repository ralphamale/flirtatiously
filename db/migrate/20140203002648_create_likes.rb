class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :liker_id
      t.integer :likee_id
      t.boolean :is_mutual

      t.timestamps
    end
    
    add_index :likes, :liker_id
    add_index :likes, :likee_id
    
  end
end
