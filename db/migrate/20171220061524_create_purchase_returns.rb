class CreatePurchaseReturns < ActiveRecord::Migration[5.1]
  def change
    create_table :purchase_returns do |t|
      t.string :claim_no
      t.string :claim_date
      t.string :product_code
      t.string :item_description
      t.string :supplier_code
      t.string :quantity
      t.string :free_quantity
      t.string :batch
      t.string :expiry_date
      t.string :status
      t.string :mrp
      t.string :rate
      t.string :remarks
      t.string :claim_amount
      t.string :settled_amount
 t.belongs_to :supplier, foreign_key: true
      t.belongs_to :product, foreign_key: true

      t.timestamps
    end
  end
end
