class CreateClaimSyns < ActiveRecord::Migration[5.1]
  def change
    create_table :claim_syns do |t|
      t.integer :p_code
      t.string :describtion
      t.string :packing
      t.string :batch_desc
      t.date :expiry_date
      t.integer :quantity
      t.date :bill_date
      t.string :bill_number

      t.timestamps
    end
  end
end
