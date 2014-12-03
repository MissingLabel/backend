class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :email, :password_digest, :zip_code
  validates :email, uniqueness: true, format: /.+@.+\..+/
  validates_length_of :zip_code, is: 5, message: "Zip code must be 5 digits"

end
