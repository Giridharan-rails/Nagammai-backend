class CreateNagammaiConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :nagammai_connections do |t|
      t.string :user_name
      t.string :password
      t.string :database_name
      t.string :server_name
      t.string :manual_sync_time

      t.timestamps
    end
  end
end
