class AddManualSyncToWc < ActiveRecord::Migration[5.1]
  def change
  add_column :wonder_softs, :manual_sync_time ,:integer
  end
end
