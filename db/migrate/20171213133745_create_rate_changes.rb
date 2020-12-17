class CreateRateChanges < ActiveRecord::Migration[5.1]
  def change
    create_table :rate_changes do |t|
      t.string :claim_number
      t.date :ack_date
      t.string :supplier_code
      t.string :div_code
      t.string :product_code
      t.string :product_name
      t.string :quantity
      t.string :batch
      t.string :sales_price
      t.string :rate
      t.string :bill_number
      t.string :bill_date
      t.string :claim_amount
      t.string :settled_amount
      t.belongs_to :supplier, foreign_key: true   
      t.belongs_to :division, foreign_key: true   
      t.belongs_to :product, foreign_key: true   

      t.timestamps
    end
  end
end
