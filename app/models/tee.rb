class Tee < ApplicationRecord

  belongs_to :club

  validates :color, presence: true
  validates :usga_course_rating_18, presence: true, numericality: true
  validates :slope_rating_18, presence: true, numericality: { only_integer: true }
  validates :front_9_rating, presence: true
  validates :front_9_slope, presence: true, numericality: { only_integer: true }
  validates :back_9_rating, presence: true
  validates :back_9_slope, presence: true, numericality: { only_integer: true }
  validates :bogey_rating, presence: true
  validates :gender, presence: true, length: { is: 1 }, inclusion: { in: %w(F M) }
  validates :club_id, presence: true

end
