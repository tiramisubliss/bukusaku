class Category < ApplicationRecord
  mount_base64_uploader :icon, IconUploader

  has_many :products
  has_many :articles
end
