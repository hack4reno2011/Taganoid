class Entry < ActiveRecord::Base
  belongs_to :entry_type
  belongs_to :group
  belongs_to :status

  scope :between_dates, lambda { |start_date, end_date|
    where('created_at BETWEEN ? AND ?',
          Date.parse(start_date).beginning_of_day,
          Date.parse(end_date).end_of_day)
  }




  validates_presence_of :entry_type_id,
                        :message => 'Select entry type'

  validates_presence_of :group_id,
                        :message => 'Select group'

  validates_presence_of :status_id,
                        :message => 'Select status'


  validates_length_of :title,
                      :within => 1..100,
                      :too_short => '^Title is required',
                      :too_long => 'Title must be 40 characters or less'
end
