class Club < ApplicationRecord

  has_many :tees

  validates :name, presence: true, allow_blank: false
  validates :city, presence: true, allow_blank: false
  validates :state, presence: true, allow_blank: false, length: { is: 2 }

  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search.downcase}%")
    else
      all
    end
  end

  def self.last_five
    all.order('created_at DESC').limit(5)
  end

  def date_added
    self.created_at.strftime("%B %d, %Y")
  end

end
