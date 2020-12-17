class CreateExpiryDamages < ActiveRecord::Migration[5.1]
  def change
    create_table :expiry_damages do |t|
      t.string :supplier_code
      t.string :claim_no
      t.date :ack_date
      t.string :courier_lr_number
      t.date :courier_date
      t.string :courier_weight
      t.string :ref_no
      t.string :product_code
      t.string :item_desc
      t.string :packing
      t.string :quantity
      t.string :free_quantity
      t.string :batch_desc
      t.date :expiry_date
      t.float :mrp
      t.float :rate
      t.string :claim_amount
      t.string :settled_amount
      t.belongs_to :supplier, foreign_key: true
      t.belongs_to :product, foreign_key: true

      t.timestamps
    end
  end
end
