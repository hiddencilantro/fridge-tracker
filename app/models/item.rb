class Item < ActiveRecord::Base
    validates :name, :quantity, presence: true
    
    belongs_to :list
end