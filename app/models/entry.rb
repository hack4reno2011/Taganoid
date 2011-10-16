class Entry < ActiveRecord::Base
  belongs_to :entry_types
  belongs_to :groups
  belongs_to :statuses
  
  scope :between_dates, lambda { |start_date, end_date|
    where('created_at BETWEEN ? AND ?', 
          Date.parse(start_date).beginning_of_day, 
          Date.parse(end_date).end_of_day)
  }
end
