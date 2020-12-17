require 'csv'
require 'byebug'

contacts = CSV.read('/home/altius/yantra/28March/Nagammai-backend/public/Contact.csv')
contacts.shift
contacts.map do |cont|
	case cont[7]
		when "Supplier"
			Contact.create(name: cont[1], email: cont[2], phone_number: cont[3], address: cont[4], jobs_name_type: cont[5] , jobs_name_id: cont[6], sub_contact_type: cont[7], sub_contact_id:Supplier.find_by(supplier_code: cont[10]).id , mail_allocation: cont[8], landline_number: cont[9])
		
		when "Manufacturer"
			Contact.create(name: cont[1], email: cont[2], phone_number: cont[3], address: cont[4], jobs_name_type: cont[5] , jobs_name_id: cont[6], sub_contact_type: cont[7], sub_contact_id:Manufacturer.find_by(manufacturer_code: cont[10]).id, mail_allocation: cont[8], landline_number: cont[9])
		when "Division"
			Contact.create(name: cont[1], email: cont[2], phone_number: cont[3], address: cont[4], jobs_name_type: cont[5] , jobs_name_id: cont[6], sub_contact_type: cont[7], sub_contact_id: Division.find_by(supplier_code: cont[10]) .id, mail_allocation: cont[8], landline_number: cont[9])

	end
end
