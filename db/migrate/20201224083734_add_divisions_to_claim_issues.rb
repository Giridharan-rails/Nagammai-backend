class AddDivisionsToClaimIssues < ActiveRecord::Migration[5.1]
  def change
    add_reference :claim_issues, :division, foreign_key: true
  end
end
