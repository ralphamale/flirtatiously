class CreateProfileViews < ActiveRecord::Migration
  def change
    create_table :profile_views do |t|
      t.integer :viewer_id
      t.integer :viewee_id

      t.timestamps
    end
    add_index :profile_views, :viewer_id
    add_index :profile_views, :viewee_id
    
  end
end
