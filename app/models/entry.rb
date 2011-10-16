class Entry < ActiveRecord::Base

  belongs_to :entry_type
  belongs_to :group
  belongs_to :status

  scope :between_dates, lambda { |start_date, end_date|
    where('created_at BETWEEN ? AND ?',
          Date.parse(start_date).beginning_of_day,
          Date.parse(end_date).end_of_day)
  }

  attr_accessible :photo, :photo_file_name, :photo_content_type,
                  :photo_file_size, :photo_updated_at

  has_attached_file :photo,
      :styles => {  :thumb => "100x100",
                    :medium => "200x200",
                    :large => "600x400" },
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :path => ":attachment/:id/:style.:extension",
      :url => ":s3_path_url",
      :bucket => 'taganoid'

  # FIXME (MVP): process_in_background :photo

  delegate  :url,
            :to => :photo,
            :prefix => true

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
