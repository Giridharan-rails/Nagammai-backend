class CreatePoSyns < ActiveRecord::Migration[5.1]
  def change
    create_table :po_syns do |t|
      t.integer :order_no
      t.date :order_date
      t.string :supplier_name
      t.integer :total_item
      t.integer :quantity
      t.decimal :net_amount

      t.timestamps
    end
  end
end
