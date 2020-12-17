class CreateSops < ActiveRecord::Migration[5.1]
  def change
    create_table :sops do |t|
      t.string :order_type
      t.string :payment_term
      t.string :special_offer
      t.string :claims_offer
      t.string :expiry_broken_settlement
      t.string :delivery_order_schedule
      t.date :monthly_appoinment1
      t.date :monthly_appoinment2
      t.date :monthly_appoinment3
      t.string :dispatch_mode
      t.float :current_ns
      t.float :current_ms
      t.string :image
      t.belongs_to :division, foreign_key: true

      t.timestamps
    end
  end
end
