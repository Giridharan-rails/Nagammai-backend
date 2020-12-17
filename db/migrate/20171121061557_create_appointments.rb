class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.date :appoint_date
      t.string :appoint_time
      t.string :contacts_ids
      t.string :appoint_note
      t.string :app_ontact_type
      t.integer :app_contact_id
      
      t.timestamps
    end
  end
end
