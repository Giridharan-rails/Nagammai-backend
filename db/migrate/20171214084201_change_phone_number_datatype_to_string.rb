class ChangePhoneNumberDatatypeToString < ActiveRecord::Migration[5.1]
 def self.up
    change_table :suppliers do |t|
      t.change :phone_number, :string
    end
  end
  def self.down
    change_table :suppliers do |t|
      t.change :phone_number, :bigint
    end
  end
end
