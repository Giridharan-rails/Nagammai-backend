class CreateNonFindableClaims < ActiveRecord::Migration[5.1]
  def change
    create_table :non_findable_claims do |t|
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
      t.string :mrp
      t.string :rate
      t.string :claim_amount
      t.string :settled_amount
      t.string :status
      t.string :remarks

      t.timestamps
    end
  end
end
