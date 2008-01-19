class Cardiotype < ActiveRecord::Base
  has_many :cardiosessions
  
  validates_presence_of :description
  validates_uniqueness_of :description
  
  def self.all
    self.find(:all)
  end
end
