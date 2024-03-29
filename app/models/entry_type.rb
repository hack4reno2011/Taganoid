class EntryType < ActiveRecord::Base
  has_many :entries
  
  before_validation :strip_name
  before_destroy :check_usage

  scope :ascend, order('entry_types.name ASC')
  
  def use_count
    self.entries.count
  end

  def check_usage
    raise 'Entry Type is in use' if self.use_count > 0 
  end  
  
  validates_length_of :name, 
                      :within => 1..40,
                      :too_short => '^Name is required', 
                      :too_long => 'Name must be 40 characters or less'
                      
                      
  private

  def strip_name
    self.name.strip!
  end  
end
