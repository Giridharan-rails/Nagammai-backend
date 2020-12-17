class CreateDivisions < ActiveRecord::Migration[5.1]
  def change
    create_table :divisions do |t|
      t.string :div_name
      t.string :div_code
      t.string :mfr_code      
      t.string :div_abb
      t.string :address_one
      t.string :address_two
      t.string :address_three
      t.string :city
      t.string :state
      t.string :country
      t.belongs_to :manufacturer, foreign_key: true      
      t.timestamps
    end
  end
end
