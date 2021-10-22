class ElevationRequest < ApplicationRecord
  belongs_to :creator
  enum status: [:created, :in_progress, :accepted, :rejected]
  belongs_to :created_by, class_name: 'User'
  belongs_to :target, class_name: 'User'
  belongs_to :answered_by, class_name: 'Admin', optional: true

  validates :creator_id, presence: true
  validates :status, presence: true
  validates :created_by_id, presence: true
  validates :target_id, presence: true
end
