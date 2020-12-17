class CreateSyncSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :sync_settings do |t|
      t.string :job_name
      t.string :schedule
      t.string :schedule_period
      t.string :schedule_time
      t.datetime :last_sync

      t.timestamps
    end
  end
end
