class ChangeColumnTypeReligionInProfiles < ActiveRecord::Migration
  def change
    change_column :profiles, :religion, 'integer USING CAST(body_type AS integer)'
  end
end
