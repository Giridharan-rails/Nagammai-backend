class AddColumnToExpiryDamage < ActiveRecord::Migration[5.1]
  def change
    add_column :expiry_damages, :adjustment_num, :string
    add_column :expiry_damages, :adjustment_date, :datetime
    add_column :expiry_damages, :ws_settle_amount, :string

    add_column :rate_changes, :adjustment_num, :string
    add_column :rate_changes, :adjustment_date, :datetime
    add_column :rate_changes, :ws_settle_amount, :string

    add_column :free_discounts, :adjustment_num, :string
    add_column :free_discounts, :adjustment_date, :datetime
    add_column :free_discounts, :ws_settle_amount, :string

    
    add_column :purchase_returns, :adjustment_num, :string
    add_column :purchase_returns, :adjustment_date, :datetime
    add_column :purchase_returns, :ws_settle_amount, :string


  end
end
