class CreateClaimIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :claim_issues do |t|
      t.string :description
      t.date :cut_off_date
      t.string :status
      t.string :notes
      t.belongs_to :contact, foreign_key: true
      t.belongs_to :appointment, foreign_key: true

      t.timestamps
    end
  end
end
