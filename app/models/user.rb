class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  validates :email, presence: true, uniqueness: true
  has_secure_password
  after_destroy :ensure_an_admin_remains
  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise "Can't delete last admin"
      end
    end
end
