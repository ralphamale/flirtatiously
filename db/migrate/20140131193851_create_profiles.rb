class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :sex
      t.string :sexual_orientation
      t.string :drugs
      t.text :description

      t.timestamps
    end

    add_index :profiles, :user_id
  end
end
