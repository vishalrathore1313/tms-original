class Meeting < ApplicationRecord
  
    has_many :meeting_participants
    has_many :users, through: :meeting_participants
   
    before_destroy :remove_participants
    
  
    validates :topic, presence: true
    validates :time, presence: true

    accepts_nested_attributes_for :users
  
    # Method to determine if a meeting is finished or upcoming
    def status
      time < Time.current ? 'Finished' : 'Upcoming'
    end

    def remove_participants
      users.clear
    end
  end







  