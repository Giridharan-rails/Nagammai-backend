class PurchaseOrder < ApplicationRecord
belongs_to :supplier
belongs_to :product
belongs_to :division
belongs_to :manufacturer

end
