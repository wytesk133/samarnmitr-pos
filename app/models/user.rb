class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :name
  validates_uniqueness_of :username, case_sensitive: false
  has_many :orders
end
