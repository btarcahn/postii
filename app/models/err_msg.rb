class ErrMsg < ApplicationRecord
  validates :err_code,
            presence: true,
            uniqueness: true,
            length: { maximum: 10, message: 'Only 10 characters maximum.' }
end
