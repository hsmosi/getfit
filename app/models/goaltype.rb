class Goaltype < ActiveRecord::Base
  has_many :goals
  
  validates_presence_of :description
  validates_presence_of :focus
  validates_inclusion_of :focus, :in => ['G', 'L', 'D', 'T']
  
  def self.all
    self.find(:all)
  end
end
