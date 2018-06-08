class Product < ApplicationRecord
  belongs_to :category, optional: true
  has_many :images
  has_many :enquiries
end
