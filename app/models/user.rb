class User < ApplicationRecord

  has_many :rounds
  has_many :tees, through: :rounds

  attr_accessor :remember_token

  before_save { self.email = email.downcase }

  validates :username, presence: true, length: { minimum: 6 }, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  def self.user_search(search)
    if search
      where('lower(username) LIKE ?', "%#{search.downcase}%")
    else
      all.order('username ASC')
    end
  end

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }

  # Define User.<class methods>
  class << self
    # Returns the hash digest of a given string
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    # Bypass methods because no access to user password
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest
  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forget a user
  def forget
    update_attribute :remember_digest, nil
  end

  def last_played
    !self.rounds.empty? ? self.rounds.order('date_played DESC').first : nil
  end

  def handicap_index
    differentials = {
      5  => 1,
      6  => 1,
      7  => 2,
      8  => 2,
      9  => 3,
      10 => 3,
      11 => 4,
      12 => 4,
      13 => 5,
      14 => 5,
      15 => 6,
      16 => 6,
      17 => 7,
      18 => 8,
      19 => 9,
      20 => 10
    }

    best = self.rounds.collect { |r| r.round_handicap_differential }.sort.first(differentials[self.rounds.count])

    best.each_with_index do |b, i|
      best[i] = b.round(1)
    end

    ((( best.sum / differentials[self.rounds.count] ) * 0.96 ) * 10.0).floor / 10.0

  end

end
