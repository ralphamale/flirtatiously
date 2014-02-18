class AddZipCodeToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :zip_code, :integer
  end
end
