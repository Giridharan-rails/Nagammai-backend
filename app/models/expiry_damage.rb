class ExpiryDamage < ApplicationRecord
belongs_to :supplier
belongs_to :product
has_many :adjustments, as: :claim_product


end
