class ChangeClaimJobIdToUnique < ActiveRecord::Migration[6.1]
  def change
    change_column :claims, :job_id, :bigint, unique: true
  end
end
