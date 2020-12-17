class AddColumnToExcessStock < ActiveRecord::Migration[5.1]
  def change
    add_column :excess_stocks, :batch_discription, :string
    add_column :excess_stocks, :expiry_date, :datetime
  end
end
