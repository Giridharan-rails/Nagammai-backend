class Supplier < ApplicationRecord
 has_many :manufacturers	
 #has_many :contacts, as: :sub_contact
 #has_many :appointments, as: :app_contact
 has_many :products
 has_many :claims
 has_many :free_discounts
 has_many :rate_changes
 has_many :expiry_damages
 has_many :purchase_returns
 has_many :goods_received_notes
 has_many :pogr_mismatches
 #has_many :sops
end
