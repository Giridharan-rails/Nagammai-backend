class Contact < ApplicationRecord
	belongs_to :jobs_name, polymorphic: true
	belongs_to :sub_contact, polymorphic: true
end
