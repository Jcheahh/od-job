class RenameLongtitudeToLongitude < ActiveRecord::Migration[6.1]
  def change
    rename_column :jobs, :pick_up_longtitude, :pick_up_longitude
    rename_column :jobs, :drop_off_longtitude, :drop_off_longitude
  end
end
