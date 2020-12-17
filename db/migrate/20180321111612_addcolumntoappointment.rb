class Addcolumntoappointment < ActiveRecord::Migration[5.1]
  def change
       remove_column :appointments, :supplier_id, :integer
  	add_column :appointments, :supplier_id, :integer
  end
end
