class MarketingTitle < ApplicationRecord
has_many :contacts, as: :jobs_name
end
