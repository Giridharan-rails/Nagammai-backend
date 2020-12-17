class SettledClaim < ApplicationRecord
  belongs_to :supplier
  belongs_to :claim
end
