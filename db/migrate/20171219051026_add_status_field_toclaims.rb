class AddStatusFieldToclaims < ActiveRecord::Migration[5.1]
  def change
	add_column :free_discounts, :status, :string
 add_column :expiry_damages, :status, :string
 add_column :rate_changes, :status, :string
 add_column :free_discounts, :remarks, :string
 add_column :expiry_damages, :remarks, :string
 add_column :rate_changes, :remarks, :string
add_column :purchase_orders, :packings, :string
add_column :purchase_returns, :courier_lr_number, :string
add_column :purchase_returns, :courier_date, :string
add_column :purchase_returns, :courier_weight, :string
add_column :free_discounts, :packings, :string
add_column :free_discounts, :mrp, :string
add_column :free_discounts, :free_quantity, :string
 add_column :expiry_damages, :product_status, :string
add_column :purchase_returns, :product_status, :string

 add_column :expiry_damages, :actual_amount, :float
 add_column :rate_changes, :actual_amount, :float
 add_column :free_discounts, :actual_amount, :float
 add_column :purchase_returns, :actual_amount, :float
 add_column :adjustments, :actual_amount,:float

  end
end
