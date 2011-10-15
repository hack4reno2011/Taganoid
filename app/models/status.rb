class Status < ActiveRecord::Base
  has_many :entries
end
