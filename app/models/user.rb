require 'digest'
class User
  include Neo4j::ActiveNode
  property :id
  property :email
  property :name
  property :password
  property :password_digest
  property :created_at, type: DateTime
  property :updated_at, type: DateTime
  property :remember_token

  property :confirmation_token
  property :confirmed_at, type: DateTime
  property :confirmation_sent_at, type: DateTime

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validate :email_uniqueness
  validates :password, length: { minimum: 6 }
  validates_confirmation_of :password,
                          if: lambda { |m| m.password.present? }
  index :email
  index :remember_token

  before_save { self.email = email.downcase }
  before_save :secure_password

  before_create :create_remember_token
  before_create :create_confirmation_token
  after_create  :send_email_confirmation

  class << self

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

    def encrypt_password(email, password)
      secure_hash("#{secure_hash("#{email}-#{password}")}-#{password}")
    end

    def new_random_token
      SecureRandom.urlsafe_base64
    end

    def hash(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
  end

  def email_uniqueness
    user = User.find(email: email)
    if user.present? and user.email_changed?
      errors.add(:email, "already exist.")
    end
  end


    def secure_password
    self.password = User.encrypt_password(email, password)
   end

  def create_remember_token
    # Create the remember token.
     self.remember_token = User.hash(User.new_random_token)
  end

  def create_confirmation_token
    # Create the confirmation token.
     self.confirmation_token = User.hash(User.new_random_token)
     self.confirmation_sent_at = Time.now.utc
  end

   def send_email_confirmation
    Notification.send_confirmation_email(self).deliver
  end

  def confirmed?
    self.confirmed_at.present?
  end

end