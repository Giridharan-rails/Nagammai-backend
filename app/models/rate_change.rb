class RateChange < ApplicationRecord
	belongs_to :supplier
	belongs_to :product
	belongs_to :division
	has_many :adjustments, as: :claim_product


end
