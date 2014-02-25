class AddProfileIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :profile_id, :integer
  end
end
