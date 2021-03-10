class User < ActiveRecord::Base
    has_secure_password

    attr_accessor :skip_validations
    
    validates :username, :firstname, :lastname, presence: true
    validates :password, presence: true, unless: :skip_validations
    validates :username, uniqueness: true

    has_many :lists
    has_many :items, through: :lists
end