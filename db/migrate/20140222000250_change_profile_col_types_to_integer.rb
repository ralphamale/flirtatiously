class ChangeProfileColTypesToInteger < ActiveRecord::Migration
  def change
    change_column :user_filters, :sexual_orientation, 'integer USING CAST(sexual_orientation AS integer)'
    change_column :profiles, :sexual_orientation, 'integer USING CAST(sexual_orientation AS integer)'
    change_column :profiles, :body_type, 'integer USING CAST(body_type AS integer)'
    change_column :profiles, :drugs, 'integer USING CAST(drugs AS integer)'
    change_column :profiles, :smokes, 'integer USING CAST(smokes AS integer)'
  end
end
