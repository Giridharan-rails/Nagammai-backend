class CreateNonMovingStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :non_moving_stocks do |t|
      t.string :product_code
      t.string :product_name
      t.string :batch_description
      t.date :received_date
      t.date :last_sale_date
      t.string :cost_val
      t.string :invoice_number
      t.string :uuu
      t.belongs_to :product, foreign_key: true

      t.timestamps
    end
  end
end
