class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rater_id
      t.integer :ratee_id
      t.boolean :likes
      t.boolean :is_mutual

      t.timestamps
    end

    add_index "ratings", ["rater_id", "rater_id"], unique: true
    add_index "ratings", ["ratee_id", "rater_id"], unique: true
    add_index "ratings", "ratee_id"
    add_index "ratings", "rater_id"

  end
end
