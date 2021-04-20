class AddTitleAndDescriptionToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :title, :string, null: false
    add_column :jobs, :description, :string

    change_column_null :jobs, :pick_up_address, false
    change_column_null :jobs, :drop_off_address, false
    change_column_null :jobs, :pick_up_longtitude, false
    change_column_null :jobs, :pick_up_latitude, false
    change_column_null :jobs, :drop_off_longtitude, false
    change_column_null :jobs, :drop_off_latitude, false
  end
end
