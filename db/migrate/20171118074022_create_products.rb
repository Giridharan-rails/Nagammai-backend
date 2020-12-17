class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :product_code
      t.string :division_code
      t.string :supplier_code
      t.string :packing
      t.string :hsn_code
      t.string :gst_tax
      t.float :purchase_price
      t.float :sales_price
      t.float :mrp
      t.date :last_sale_date
      t.date :last_receive_date
      t.string :total_stock      
      t.belongs_to :division, foreign_key: true
      t.belongs_to :supplier, foreign_key: true
      t.timestamps
    end
  end
end
