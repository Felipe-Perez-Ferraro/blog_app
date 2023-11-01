class User < ApplicationRecord
  validates :user_name, presence: true
  validates :photo, presence: true
end
