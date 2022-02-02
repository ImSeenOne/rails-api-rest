class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :name, presence: true
end
