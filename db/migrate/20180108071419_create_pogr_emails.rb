class CreatePogrEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :pogr_emails do |t|
      t.string :order_no
      t.string :email
      t.string :status

      t.timestamps
    end
  end
end
