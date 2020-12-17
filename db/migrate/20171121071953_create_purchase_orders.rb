class CreatePurchaseOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :purchase_orders do |t|
      t.string :order_no
      t.date :order_date
      t.string :free_qty
      t.string :quantity
      t.string :amount
      t.string :status
      t.string :product_code
      t.string :product_name
      t.string :old_id
      t.string :supplier_code
      t.string :mfr_code
      t.string :div_code
      t.belongs_to :supplier, foreign_key: true
      t.belongs_to :manufacturer, foreign_key: true
      t.belongs_to :division, foreign_key: true
      t.belongs_to :product, foreign_key: true
      
      t.timestamps
    end
  end
end
