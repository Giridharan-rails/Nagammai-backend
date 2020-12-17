class AddFieldsToReceivemail < ActiveRecord::Migration[5.1]
  def change
    add_column :receive_mails, :email1 ,:string
    add_column :receive_mails, :password1 ,:string
     add_column :receive_mails, :email2 ,:string
    add_column :receive_mails, :password2 ,:string
    add_column :receive_mails, :to_mail ,:string
    remove_column :receive_mails, :email ,:string
    remove_column :receive_mails, :password ,:string

end
end
