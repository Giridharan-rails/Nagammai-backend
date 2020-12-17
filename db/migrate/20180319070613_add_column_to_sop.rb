class AddColumnToSop < ActiveRecord::Migration[5.1]
  def change
  add_reference :sops, :supplier, index: true
 add_column :sops, :appoint_time1, :string
add_column :sops, :appoint_time2, :string
add_column :sops, :appoint_time3, :string
  end
end
