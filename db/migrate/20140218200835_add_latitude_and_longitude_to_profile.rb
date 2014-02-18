class AddLatitudeAndLongitudeToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :latitude, :float
    add_column :profiles, :longitude, :float
  end
end
