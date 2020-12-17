class CreateMailConfigurations < ActiveRecord::Migration[5.1]
  def change
    create_table :mail_configurations do |t|
      t.string :from_mail
      t.string :from_password
      t.string :cc_mail
      t.string :cc_password

      t.timestamps
    end
  end
end
