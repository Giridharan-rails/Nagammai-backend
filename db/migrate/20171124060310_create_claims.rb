class CreateClaims < ActiveRecord::Migration[5.1]
  def change
    create_table :claims do |t|
      t.string :claim_no
      t.string :type_of_claim
      t.date :claim_date
      t.string :product_code
      t.date :expiry_date
      t.integer :quantity
      t.float :claim_amount
      t.float :settled_amount
      t.date :bill_date
      t.string :bill_number
      t.string :status
      t.string :supplier_code
      t.belongs_to :supplier, foreign_key: true

      t.timestamps
    end
  end
end
