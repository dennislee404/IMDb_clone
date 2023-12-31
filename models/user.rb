class User < ActiveRecord::Base
	has_secure_password
	has_many :reviews

	validates :password, length: { minimum: 8}
	mount_uploader :user_photo, PhotoUploader
end