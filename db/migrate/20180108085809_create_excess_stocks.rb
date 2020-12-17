class CreateExcessStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :excess_stocks do |t|
      t.string :product_code
      t.string :product_name
      t.string :pakage_information
      t.string :unit_description
      t.integer :quantity
      t.integer :free_quantity
      t.string :excess_stock
      t.string :current_stock
      t.float  :mrp
      t.string :supplier_code
      t.string :division_code
      t.string :status
      t.float  :csv_cost
      t.string :csv_purchase
      t.float  :esv_cost
      t.float  :esv_purchase
      t.belongs_to :supplier, foreign_key: true
      t.belongs_to :product, foreign_key: true
      t.belongs_to :division, foreign_key: true


      t.timestamps
    end
  end
end
