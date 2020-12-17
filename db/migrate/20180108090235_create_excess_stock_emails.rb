class CreateExcessStockEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :excess_stock_emails do |t|
      t.string :product_code
      t.string :email
      t.string :status

      t.timestamps
    end
  end
end
