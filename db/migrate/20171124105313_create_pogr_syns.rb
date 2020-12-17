class CreatePogrSyns < ActiveRecord::Migration[5.1]
  def change
    create_table :pogr_syns do |t|
      t.string :gr_no
      t.date :date
      t.string :invoice_no
      t.string :supplier_name
      t.decimal :gross_amount

      t.timestamps
    end
  end
end
