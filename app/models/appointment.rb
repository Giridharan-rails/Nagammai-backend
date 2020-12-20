class Appointment < ApplicationRecord
  belongs_to :app_contact, polymorphic: true
  has_many :claim_issues, :dependent => :destroy
  belongs_to :user, optional: :true
 
  def  self.monthly_appointment_create
     from_date=Date.current.beginning_of_month+1.month
     to_date=Date.current.end_of_month+1.month
     Appointment.where(:appoint_date=>(from_date..to_date)).map {|i| Appointment.create(:appoint_date=>i.appoint_date+1.month,appoint_time:i.appoint_time, contacts_ids: i.contacts_ids, appoint_note: i.appoint_note, app_contact_id: i.app_contact_id, app_contact_type: i.app_contact_type, mail_status: i.mail_status)}

  end

end
