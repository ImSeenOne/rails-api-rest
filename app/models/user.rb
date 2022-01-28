class User < ApplicationRecord
  validates :id, presence: true, uniqueness: true
  validates :title, presence: true
  validates :content, presence: true
end
