class AddUsersToClaimIssues < ActiveRecord::Migration[5.1]
  def change
    add_reference :claim_issues, :user, foreign_key: true
  end
end
