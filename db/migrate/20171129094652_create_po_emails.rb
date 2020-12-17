class CreatePoEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :po_emails do |t|
      t.string :order_no
      t.date :order_date
      t.string :email
      t.string :status

      t.timestamps
    end
  end
end
