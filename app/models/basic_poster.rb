class BasicPoster < ApplicationRecord
  belongs_to :creator
  has_many :quests, dependent: :destroy
  validates :poster_id, presence: true, uniqueness: true
end
