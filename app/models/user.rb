class User < ApplicationRecord
    has_many :reservations
    
    validates :name, presence: true
    validates :user_name, presence: true
end
    