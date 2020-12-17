class CreateGoodsReceivedNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :goods_received_notes do |t|
      t.string :grn_number
      t.date :grn_date
      t.string :invoice_number
      t.date :invoice_date
      t.string :quantity
      t.string :free_qunatity
      t.string :gross
      t.string :tax
      t.string :amount
      t.string :product_code
      t.string :product_name
      t.string :supplier_code
      t.string :supplier_name
      t.string :batch_description
      t.string :purchase_price
      t.string :mrp
      t.string :purchase_taxcode
      t.string :remarks
      t.string :supplier_gstnumber
      t.string :status
      t.belongs_to :product, foreign_key: true
      t.belongs_to :supplier, foreign_key: true

      t.timestamps
    end
  end
end
