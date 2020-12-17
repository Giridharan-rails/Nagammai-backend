class AddFiledToClaimIssue < ActiveRecord::Migration[5.1]
  def change
   add_column :claim_issues, :manual_status, :string
  end
end
