class ClaimIssue < ApplicationRecord
  belongs_to :appointment
  belongs_to :contact
end
