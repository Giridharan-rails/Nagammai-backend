class CreateFreeDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :free_discounts do |t|
      t.string :claim_no
      t.date :ack_date
      t.string :supplier_code
      t.string :customer_name
      t.string :product_code
      t.string :product_name
      t.string :total_quantity
      t.string :rate
      t.string :overall_discount_percentage
      t.string :overall_discount_amount
      t.string :bill_number
      t.string :bill_date
      t.string :claim_amount
      t.string :settled_amount
      t.belongs_to :supplier, foreign_key: true
      t.belongs_to :product, foreign_key: true

      t.timestamps
    end
  end
end
