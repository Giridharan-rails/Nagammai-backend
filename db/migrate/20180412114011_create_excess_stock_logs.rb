class CreateExcessStockLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :excess_stock_logs do |t|
      t.string :unique_no
      t.string :description
      t.string :reason

      t.timestamps
    end
  end
end
