class Entry < ActiveRecord::Base
  belongs_to :entry_types
  belongs_to :groups
  belongs_to :statuses
end
