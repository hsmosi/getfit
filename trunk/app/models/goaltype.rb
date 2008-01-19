class Goaltype < ActiveRecord::Base
  has_many :goals
  
  validates_presence_of :description
  
  def self.all
    self.find(:all)
  end
end
