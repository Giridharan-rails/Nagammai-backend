class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.bigint :phone_number
      t.string :address
      t.string :jobs_name_type
      t.integer :jobs_name_id
      t.string :sub_contact_type
      t.integer :sub_contact_id
      t.string :mail_allocation  

      t.timestamps
    end
  end
end
