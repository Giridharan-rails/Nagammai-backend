class CreatePurchaseReturnEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :purchase_return_emails do |t|
      t.string :claim_no
      t.date :claim_date
      t.string :email
      t.string :status

      t.timestamps
    end
  end
end
