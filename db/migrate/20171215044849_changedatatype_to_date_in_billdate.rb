class ChangedatatypeToDateInBilldate < ActiveRecord::Migration[5.1]
def self.up
    change_table :free_discounts do |t|
      t.change :bill_date, 'date USING CAST(bill_date AS date)'
    end
    change_table :rate_changes do |t|
      t.change :bill_date, 'date USING CAST(bill_date AS date)'
    end

  end
  def self.down
    change_table :free_discounts do |t|
      t.change :bill_date, :string
    end
    change_table :rate_changes do |t|
      t.change :bill_date, :string
    end

  end

end
