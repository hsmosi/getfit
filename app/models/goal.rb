class Goal < ActiveRecord::Base
  belongs_to :goaltype
  belongs_to :cardiotype
  belongs_to :user
  
  #validates_existence_of :user
  validates_presence_of :target_date, :message => "Every goal must have a target date"
  validates_presence_of :user_id, :message => "Goals must be owned by a user"
  validates_presence_of :goaltype_id, :message => "Each goal must be associated with a type"
  validates_presence_of :target_weight, :message => "A target weight must be specified", :if => :is_weight_based
  validates_numericality_of :target_weight, :allow_nil => true, :message => "Target weight must be a number"
  validates_presence_of :target_distance, :message => "A target distance must be specified", :if => :is_distance_based
  validates_numericality_of :target_distance, :allow_nil => true, :message => "Target distance must be a number"
  validates_presence_of :target_time, :message => "A time must be specified", :if => :is_time_based
  validates_numericality_of :target_time, :allow_nil => true, :message => "Target distance must be a number"
  
  def self.all_active(user)
    self.find(:all, :conditions => "user_id = #{user.id}")
  end
  
  def self.all_completed(user)
    self.find(:all, :conditions => "user_id = #{user.id}")
  end
  
  def target_time_as_text=(text)
    @originaltext = text
    self.target_time = Time.time_from_text(text)
    @originaltext = nil if !self.target_time.nil?
  end
  
  def target_time_as_text
    r = ""
    if !@originaltext.nil?
      r = @originaltext
    elsif 
      if !self.target_time.nil?
        r = self.target_time.time_as_text
      end
    end
    r
  end
  
  def target_time_in_seconds
    dhms2sec(0, self.target_time.hour, self.target_time.min, self.target_time.sec)
  end
  
  def succeeded
    if self.target_date > Date.today
      false
    else
      if self.is_time_based || self.is_distance_based
        last_session = Cardiosession.last_session_for_type(self.user, self.target_date, self.cardiotype)
        if last_session.nil?
          return false
        else
          (return last_session.laptime_in_seconds <= self.target_time_in_seconds) if self.is_time_based
          (return last_session.distance >= self.target_distance) if self.is_distance_based
        end
      elsif self.is_weight_based
        last_weight = Body.last_measurement(self.user, self.target_date)
        if (last_weight.nil?)
          return false
        else
          (return last_weight.weight >= self.target_weight) if self.is_gain_weight
          (return last_weight.weight <= self.target_weight) if self.is_lose_weight
        end
      end
      false
    end
  end
  
  def is_gain_weight
    return !self.goaltype.nil? && self.goaltype.focus == "G";
  end
  
  def is_lose_weight
    return !self.goaltype.nil? && self.goaltype.focus == "L";
  end
  
  def is_weight_based
    return !self.goaltype.nil? && (self.goaltype.focus == "G" || self.goaltype.focus == "L")
  end
  
  def is_time_based
    return !self.goaltype.nil? && self.goaltype.focus == "T"
  end
  
  def is_distance_based
    return !self.goaltype.nil? && self.goaltype.focus == "D"
  end
  
  def as_text
    self.goaltype.templatedescription.gsub('@w', self.target_weight.to_s).gsub('@d',self.target_date.date_as_text).gsub('@t', self.target_time_as_text).gsub('@r', self.target_distance.to_s)
  end
end
