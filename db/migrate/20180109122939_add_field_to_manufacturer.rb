class AddFieldToManufacturer < ActiveRecord::Migration[5.1]
  def change
add_reference :manufacturers, :supplier, foreign_key: true, index: true
add_column :contacts, :landline_number ,:string
add_column :suppliers, :expiry_broken,:string
add_column :suppliers, :batch, :string
add_column :sync_settings, :additional1,:string
add_column :sync_settings, :additional2,:string
add_column :sync_settings, :additional3,:string
add_column :excess_stocks, :excess_no ,:string
  end
end
