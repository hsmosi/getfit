class Goal < ActiveRecord::Base
  belongs_to :goaltype
  
  validates_presence_of :target_date, :message => "Every goal must have a target date"
  validates_presence_of :user_id, :message => "Goals must be owned by a user"
  validates_numericality_of :target_weight, :allow_nil => true, :message => "If specified the target weight must be a number"
  
  def self.all_active(user)
    self.find(:all, :conditions => "user_id = #{user.id}")
  end
  
  def self.all_completed(user)
    self.find(:all, :conditions => "user_id = #{user.id}")
  end
end
