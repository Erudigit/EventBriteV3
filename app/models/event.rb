class Event < ApplicationRecord

    has_many :users, through: :attendances
    has_many :attendances

    validates :start_date, presence: true
    validates :duration, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true
    validates :location, presence: true
end
