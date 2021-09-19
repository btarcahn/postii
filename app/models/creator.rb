class Creator < ApplicationRecord
  has_many :basic_posters, dependent: :destroy
end
