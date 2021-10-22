class Creator < ApplicationRecord
  has_many :basic_posters, dependent: :destroy
  has_many :elevation_requests, dependent: :destroy
end
