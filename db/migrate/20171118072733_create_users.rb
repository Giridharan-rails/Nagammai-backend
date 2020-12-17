class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password
      t.string :email
      t.string :role
      t.string :supplier_id

      t.timestamps
    end
  end
end
