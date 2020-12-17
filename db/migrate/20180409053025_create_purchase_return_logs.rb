class CreatePurchaseReturnLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :purchase_return_logs do |t|
      t.string :claim_no
      t.string :description
      t.string :reason

      t.timestamps
    end
  end
end
