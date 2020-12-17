class CreateSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers do |t|
      t.string :supplier_name
      t.string :supplier_code
      t.string :supplier_abb
      t.string :address_one
      t.string :addrsss_two
      t.string :addrsss_three            
      t.string :gst_no
      t.string :order_copy_format
      t.bigint :phone_number
      t.string :city
      t.string :state
      t.string :country
      t.timestamps
    end
  end
end
