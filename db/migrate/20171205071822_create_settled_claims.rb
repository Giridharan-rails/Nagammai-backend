class CreateSettledClaims < ActiveRecord::Migration[5.1]
  def change
    create_table :settled_claims do |t|
      t.string :settled_claim_no
      t.string :claim_no
      t.date :settled_date
      t.integer :settled_qty
      t.float :settled_amount
      t.string :supplier_code
      t.string :product_code
      t.belongs_to :supplier, foreign_key: true
      t.belongs_to :claim, foreign_key: true

      t.timestamps
    end
  end
end
