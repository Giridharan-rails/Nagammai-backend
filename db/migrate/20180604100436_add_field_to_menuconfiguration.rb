class AddFieldToMenuconfiguration < ActiveRecord::Migration[5.1]
  def change
 add_column :mail_configurations, :log_mail, :string
  end
end
