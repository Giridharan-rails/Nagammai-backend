class AddColumnToClaimIssue < ActiveRecord::Migration[5.1]
  def change
    add_column :claim_issues, :remarks, :string
  end
end
