class Body < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :user, :message => "Body measurement must be associated with a user"
  validates_numericality_of :weight, :message => "Weight must be a number", :allow_nil => true
  validates_presence_of :weight, :message => "Weight must be given"
  validates_presence_of :measurementdate, :message => "A date must be given"
  
  def self.bodies_for_user(user)
    self.find(:all, :conditions => "user_id = #{user.id}", :order => "measurementdate desc")
  end
end
