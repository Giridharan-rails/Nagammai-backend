class CreateClaimMails < ActiveRecord::Migration[5.1]
  def change
    create_table :claim_mails do |t|
      t.string :email
      t.string :claim_no
      t.string :status
      t.belongs_to :claim, foreign_key: true

      t.timestamps
    end
  end
end
