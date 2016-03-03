class User < ActiveRecord::Base

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy

	validates :email, presence: true, :uniqueness => true, length: 6..50, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
	validates :password, presence: true, length: { minimum: 6 }
	before_save :encrypt_password
	after_save :clear_password

	attr_accessor :password, :email

	def encrypt_password
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
		end
	end

	def clear_password
		 self.password = nil
	end

	def user_data
		@user_data ||= [self.email, self.password].compact.join(' ')
	end
end
