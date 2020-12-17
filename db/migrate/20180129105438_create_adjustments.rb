class CreateAdjustments < ActiveRecord::Migration[5.1]
  def change
    create_table :adjustments do |t|
      t.float :credit_amount
      t.string :credit_note_num
      t.date :credit_date
      t.string :remark
      t.integer :adjust_quantity
      t.string :claim_product_type
      t.integer :claim_product_id

      t.timestamps
    end
  end
end
