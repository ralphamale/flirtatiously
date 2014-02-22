class AddLikestoLikes < ActiveRecord::Migration
  def change
    add_column :likes, :likes, :boolean
  end
end
