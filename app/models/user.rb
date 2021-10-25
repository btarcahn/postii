class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,
         :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  self.inheritance_column = :role

  def self.roles
    %w(SuperUser Admin User)
  end

  belongs_to :creator, optional: true

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validates :role, presence: true, inclusion: { in: self.roles }

  # TODO add validation: if object is User, it must belong to a Creator
end
