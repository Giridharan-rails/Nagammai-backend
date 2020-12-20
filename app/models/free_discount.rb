class FreeDiscount < ApplicationRecord
 belongs_to :supplier
 belongs_to :product
 has_many :adjustments, as: :claim_product
 include ClaimData

end
