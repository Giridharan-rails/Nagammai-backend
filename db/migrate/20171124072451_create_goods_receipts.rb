class CreateGoodsReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :goods_receipts do |t|
      t.string :gr_no
      t.date :gr_date
      t.string :invoice_no
      t.float :amount
      t.integer :quantity
      t.string :purchase_order_code
      t.string :product_code
      t.string :supplier_code
      t.string :status
      t.belongs_to :product, foreign_key: true
      t.belongs_to :supplier, foreign_key: true

      t.timestamps
    end
  end
end
  