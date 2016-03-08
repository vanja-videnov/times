class User < ActiveRecord::Base
	EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy

	 validates :email, presence: true, uniqueness: true, length: 6..50, format: { with: self::EMAIL_REGEXP, on: :create }
	has_secure_password
	 validates :password_digest, presence: true, length: { minimum: 6 }
	 validates :phone, format: { with: /\d{3}\d{3}\d{4}/ ,message: "only allows numbers", allow_blank: true}
	 validates :user_type, presence: true, :inclusion => {:in => [true, false]}, allow_nil: false
	 before_save :encrypt_password

	def encrypt_password
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.password_digest= BCrypt::Engine.hash_secret(password_digest, salt)
		end
	end

	def user_data
		@user_data ||= [self.name, self.email, self.phone].compact.join(' ')
	end
end
