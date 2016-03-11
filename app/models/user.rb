class User < ActiveRecord::Base
	EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy

	 validates :email, presence: true, uniqueness: true, length: 6..50, format: { with: self::EMAIL_REGEXP, on: :create }
	 validates :password, presence: true, length: { minimum: 6 }
	 validates :phone, format: { with: /\d{3}\d{3}\d{4}/ ,message: "only allows numbers", allow_blank: true}
	 validates :admin, inclusion: {in: [true, false]}
	 before_save :encrypt_password

	def encrypt_password
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.password= BCrypt::Engine.hash_secret(password, salt)
		end
	end

	def authenticate(password)
		hash = BCrypt::Engine.hash_secret(password, self.salt)
		# if hash == self.password
		# 	true
		# else
		# 	false
		# end
		hash == self.password
	end


end
