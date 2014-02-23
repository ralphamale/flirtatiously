class FixIndexOnRatings < ActiveRecord::Migration
  def change
    remove_index "ratings", :name => "index_ratings_on_rater_id_and_rater_id"
    add_index "ratings", ["rater_id", "ratee_id"], unique: true

  end
end
