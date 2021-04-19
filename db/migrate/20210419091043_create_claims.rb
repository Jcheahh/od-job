class CreateClaims < ActiveRecord::Migration[6.1]
  def change
    create_table :claims do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true, unique: true
      t.column :status, :integer, default: 0

      t.timestamps
    end
  end
end
