class ClaimIssue < ApplicationRecord
  belongs_to :appointment, optional: :true
  belongs_to :contact
  belongs_to :division
  belongs_to :user
end
