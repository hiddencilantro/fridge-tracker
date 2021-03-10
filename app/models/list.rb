class List < ActiveRecord::Base
    validates :title, :date, presence: true
    
    belongs_to :user
    has_many :items
end