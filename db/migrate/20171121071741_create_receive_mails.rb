class CreateReceiveMails < ActiveRecord::Migration[5.1]
  def change
    create_table :receive_mails do |t|
      t.string :job_name
      t.string :schedule
      t.string :schedule_period
      t.string :schedule_time
      t.datetime :last_sync
	t.string :path_setting
      t.timestamps
    end
  end
end
