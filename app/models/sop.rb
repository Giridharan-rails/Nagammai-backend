class Sop < ApplicationRecord
  belongs_to :division
  belongs_to :supplier
  mount_uploader :image, ImageUploader
end
