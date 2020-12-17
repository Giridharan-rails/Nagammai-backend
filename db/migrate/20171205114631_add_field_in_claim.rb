class AddFieldInClaim < ActiveRecord::Migration[5.1]
  def change
  add_column :claims, :description ,:string
  add_column :appointments, :app_contact_type, :string
  remove_column :appointments, :app_ontact_type, :string
  add_column :claim_issues, :approval, :boolean

  end
end
