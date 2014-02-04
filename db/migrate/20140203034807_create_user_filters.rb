class CreateUserFilters < ActiveRecord::Migration
  def change
    create_table :user_filters do |t|
      t.integer :user_id
      t.integer :beg_age
      t.integer :end_age
      t.string :sex
      t.string :sexual_orientation

      t.timestamps
    end
    
    add_index :user_filters, :user_id
    
  end
end
