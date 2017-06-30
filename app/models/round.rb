class Round < ApplicationRecord

  belongs_to :user
  belongs_to :tee
  belongs_to :club

  validates :adjusted_score, presence: true, numericality: { only_integer: true }
  validates :date_played, presence: true
  validates_presence_of :user_id
  validates_presence_of :tee_id

end
