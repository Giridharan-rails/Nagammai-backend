class Division < ApplicationRecord
  has_many :contacts, as: :sub_contact
  has_many :appointments, as: :app_contact
  has_many :claims
  belongs_to :manufacturer
  has_many :products
  has_many :rate_changes
  has_many :sops
end
