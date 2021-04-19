class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :pick_up_address
      t.string :drop_off_address
      t.decimal :pick_up_longtitude, precision: 10, scale: 6
      t.decimal :pick_up_latitude, precision: 10, scale: 6
      t.decimal :drop_off_longtitude, precision: 10, scale: 6
      t.decimal :drop_off_latitude, precision: 10, scale: 6

      t.timestamps
    end
  end
end
