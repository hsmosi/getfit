class Body < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :user, :message => "Body measurement must be associated with a user"
  validates_numericality_of :weight, :message => "Weight must be a number", :allow_nil => true
  validates_presence_of :weight, :message => "Weight must be given"
  validates_presence_of :measurementdate, :message => "A date must be given"
  
  def self.for_user(user)
    self.find(:all, :conditions => "user_id = #{user.id}", :order => "measurementdate desc")
  end
  
  def self.top_five(user)
    self.find(:all, :conditions => "user_id = #{user.id}", :order => "measurementdate desc", :limit => 5)
  end
  
  def self.last_month(user)
    startdate = Date.today - 28.days
    self.find(:all, :conditions => "user_id = #{user.id} AND measurementdate > '#{startdate.to_formatted_s(:db)}'", :order => "measurementdate desc")
  end
  
  def self.last_measurement(user, beforedate)
    self.find(:first, :conditions => "user_id = #{user.id} AND measurementdate <= '#{beforedate.to_formatted_s(:db)}'", :order => "measurementdate desc")
  end
end
