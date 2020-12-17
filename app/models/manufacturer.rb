class Manufacturer < ApplicationRecord
  #has_many :contacts, as: :sub_contact
  #has_many :appointments, as: :app_contact
  has_many :divisions
  belongs_to :supplier,:optional=>"true"
end
