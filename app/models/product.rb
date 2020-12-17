class Product < ApplicationRecord
  belongs_to :division
  belongs_to :supplier
  has_many :free_discounts
  has_many :rate_changes
  has_many :expiry_damages
  has_many :purchase_returns
  has_many :purchase_orders
  has_many :goods_received_notes
  has_many :pogr_mismatches
end
