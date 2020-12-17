class Adjustment < ApplicationRecord
	belongs_to :claim_product, polymorphic: true
end
