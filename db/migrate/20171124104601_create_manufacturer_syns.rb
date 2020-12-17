class CreateManufacturerSyns < ActiveRecord::Migration[5.1]
  def change
    create_table :manufacturer_syns do |t|
      t.string :name
      t.string :email
      t.bigint :phone_number
      t.string :address

      t.timestamps
    end
  end
end
