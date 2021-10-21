class ErrMsg < ApplicationRecord
  validates :err_code,
            presence: true,
            uniqueness: true,
            length: { maximum: 10, message: 'Only 10 characters maximum.' }
  validates :message, presence: true
  validates :component, presence: true
end
