class BasicPoster < ApplicationRecord
  belongs_to :creator
  has_many :quests
end
