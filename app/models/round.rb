class Round < ApplicationRecord

  belongs_to :user
  belongs_to :tee
  belongs_to :club

  validates :adjusted_score, presence: true, numericality: { only_integer: true }
  validates :date_played, presence: true
  validates_presence_of :user_id
  validates_presence_of :tee_id

  def round_handicap_differential
    (self.adjusted_score - self.tee.usga_course_rating_18) * 113 / self.tee.slope_rating_18
  end

end
