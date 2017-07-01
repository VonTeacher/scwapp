class Tee < ApplicationRecord

  has_many :rounds
  has_many :users, through: :rounds

  belongs_to :club

  validates :color, presence: true
  validates :usga_course_rating_18, presence: true, numericality: true
  validates :slope_rating_18, presence: true, numericality: { only_integer: true }
  validates :gender, presence: true, length: { is: 1 }, inclusion: { in: %w(F M) }
  validates :club_id, presence: true

end
