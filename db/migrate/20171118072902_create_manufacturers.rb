class CreateManufacturers < ActiveRecord::Migration[5.1]
  def change
    create_table :manufacturers do |t|
      t.string :manufacturer_name
      t.string :manufacturer_code
      t.string :manufacturer_abb
      t.string :address_one
      t.string :addrsss_two
      t.string :addrsss_three            
      t.string :city
      t.string :state
      t.string :country
      
      t.timestamps
    end
  end
end
