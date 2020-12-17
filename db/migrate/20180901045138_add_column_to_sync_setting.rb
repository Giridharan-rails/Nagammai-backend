class AddColumnToSyncSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :sync_settings, :last_modified_sync, :date
  end
end
