class AddFieldsToAppointmentsAndClaimIssue < ActiveRecord::Migration[5.1]
  def change
 add_column :appointments, :mail_status, :string
 add_column :claim_issues, :mail_status, :string

  end
end
