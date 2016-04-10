class User < ActiveRecord::Base

  #attr_accessible :name, :email, :date_naissance, :password, :nb_films, :m_visio_films, :nb_livres, :livres, :PDF_Cv

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  
  validates :date_naissance, 
            :presence => true,
            :date => { :before => Time.now }

  validates :nb_films,
            :presence => true, 
            :numericality => { only_integer: true, 
                               greater_than_or_equal_to: 0 }

  validates :m_visio_films,
            :presence => true

  validates :nb_livres, 
            :presence => true, 
            :numericality => { only_integer: true,
                               greater_than_or_equal_to: 0 }

  validates_inclusion_of :livres,
                         :in => [true, false]


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end