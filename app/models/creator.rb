class Creator < ApplicationRecord
  has_many :basic_posters, dependent: :destroy
  has_many :elevation_requests, dependent: :destroy
  has_many :users

  validates :email_address, uniqueness: { message: 'must be unique if sector_code is "core"' },
            if: -> { sector_code.eql?('core') }

end
