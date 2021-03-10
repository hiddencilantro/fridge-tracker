class User < ActiveRecord::Base
    has_secure_password

    validates :username, :password, :firstname, :lastname, presence: true
    validates :username, uniqueness: true

    has_many :lists
    has_many :items, through: :lists
end