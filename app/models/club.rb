class Club < ApplicationRecord
  include Dateadded

  has_many :tees

  validates :name, presence: true, allow_blank: false
  validates :city, presence: true, allow_blank: false
  validates :state, presence: true, allow_blank: false, length: { is: 2 }

  before_save   :downcase_then_titleize
  before_create :downcase_then_titleize

  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search.downcase}%")
    else
      all.order('name ASC')
    end
  end

  def downcase_then_titleize
    self.name = self.name.downcase.titleize
    self.city = self.city.downcase.titleize
    self.state = self.state.upcase
  end

end
