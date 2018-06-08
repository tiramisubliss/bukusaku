class Enquiry < ApplicationRecord
  belongs_to :product, optional: true
end
