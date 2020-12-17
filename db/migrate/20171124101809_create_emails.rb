class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.string :from_mail
      t.string :to_mail
      t.string :subject
      t.string :message
      t.string :attachment
      t.date :date
      t.string :supplier_id

      t.timestamps
    end
  end
end
