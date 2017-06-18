class Club < ApplicationRecord

  validates :name, presence: true

  validates :city, presence: true

  validates :state, presence: true, length: { is: 2 }


  def self.last_five
    all.order('created_at DESC').limit(5)
  end

end
