class AddDiscAmountToRateChange < ActiveRecord::Migration[5.1]

  def change
  add_column :rate_changes, :disc_amount, :string
  add_column :rate_changes, :gross_amount, :string
   add_column :rate_changes, :gst_num, :string
  add_column :expiry_damages, :gross_amount, :string
  add_column :expiry_damages, :gst_num, :string
  add_column :expiry_damages, :div_code, :string
  add_column :purchase_returns, :gross_amount, :string
  add_column :purchase_returns, :gst_num, :string
  add_column :purchase_returns, :div_code, :string
  add_column :free_discounts, :gross_num, :string
  add_column :free_discounts, :gst_num, :string
  add_column :free_discounts, :div_code, :string
  add_column :free_discounts, :amount_status,:integer
  add_column :expiry_damages, :amount_status,:integer
  add_column :rate_changes, :amount_status,:integer
  add_column :purchase_returns, :amount_status,:integer

  end
end
