class Cardiotype < ActiveRecord::Base
  has_many :cardiosessions
  
  validates_presence_of :description
  validates_uniqueness_of :description
  
  def self.find_by_description(description)
    self.find(:first, :conditions => "description = '#{description}'")
  end
end
