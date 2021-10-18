class User < ApplicationRecord
  self.inheritance_column = :role

  def self.roles
    %w(SuperUser Admin User)
  end

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validates :role, presence: true, inclusion: { in: self.roles }
end
