class AddFieldsToExcessstockPo < ActiveRecord::Migration[5.1]
  def change
add_column :purchase_orders, :dispatch_date, :string
add_column :purchase_orders, :overall_note, :string
add_column :excess_stocks, :batch_stock, :string
add_column :excess_stocks, :total_stock, :string
add_column :purchase_orders, :gst, :string
add_column :rate_changes, :gst, :string
add_column :free_discounts, :gst, :string
add_column :expiry_damages, :gst, :string
add_column :purchase_returns, :gst, :string
end
end
