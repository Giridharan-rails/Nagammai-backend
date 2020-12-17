class CreatePogrMismatches < ActiveRecord::Migration[5.1]
  def change
    create_table :pogr_mismatches do |t|
      t.string :po_number
      t.string :gr_number
      t.string :product_code
      t.string :product_name
      t.string :supplier_code
      t.string :supplier_name
      t.string :po_quantity
      t.string :gr_quantity
      t.string :excess_quantity
      t.string :status
      t.string :contact_ids
      t.string :failed_ids

      t.timestamps
    end
  end
end
