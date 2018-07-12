class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  after_initialize :ensure_session_token
  
  def self.find_by_credentials(name, pass)
    user = User.find_by(username: name)
    return nil unless user 
    user.is_password?(pass) ? user : nil
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save
    session_token
  end
  
  def password=(pass)
    @password = pass 
    self.password_digest = BCrypt::Password.create(pass).to_s
  end
  
  def is_password?(pass)
    BCrypt::Password.new(password_digest).is_password?(pass)
  end
  
  private 
  attr_reader :password

end
