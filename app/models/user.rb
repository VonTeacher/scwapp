class User < ApplicationRecord
  include Dateadded

  validates :username, presence: true, length: { minimum: 6 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  def self.user_search(search)
    if search
      where('lower(username) LIKE ?', "%#{search.downcase}%")
    else
      all.order('username ASC')
    end
  end

end
