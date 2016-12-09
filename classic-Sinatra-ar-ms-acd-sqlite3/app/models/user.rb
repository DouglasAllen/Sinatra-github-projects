class User < ActiveRecord::Base
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end