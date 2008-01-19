class Cardiosession < ActiveRecord::Base
  belongs_to :user
  belongs_to :cardiotype
  validates_numericality_of :distance, :message => "Distance must be a number", :allow_nil => true
  validates_presence_of :distance, :message => "Distance is required"
  validates_presence_of :timetaken, :message => "Time taken is required"
  validates_presence_of :workoutdate, :message => "Workout date is required"
  validates_presence_of :user, :message => "Must be associated with a user"
  
  def timetakenastext=(text)
    self.timetaken = nil
    @originaltext = text
    r = /((\d+):)?((\d+):)?(\d+)/
    m = r.match(text)
    if (!m.nil?)
      colonCount = m[0].count(":")
      timeString = ("00:" * (2 - colonCount)) + m[0]
      begin
        self.timetaken = Time.parse(timeString) if (colonCount >= 0 && colonCount <= 2)
        @originaltext = nil
      rescue
        self.timetaken = nil
      end
    end
  end
  
  def timetakenastext
    r = ""
    if !@originaltext.nil?
      r = @originaltext
    elsif (!self.timetaken.nil?)
      r += self.timetaken.hour.to_s.rjust(2,"0") + ":" if (self.timetaken.hour != 0)
      r += self.timetaken.min.to_s.rjust(2,"0") + ":" if (self.timetaken.min != 0)
      r += self.timetaken.sec.to_s.rjust(2,"0")
    end
    r
  end
  
  def time_in_seconds
    (self.timetaken.hour * 60 + self.timetaken.min) * 60 + self.timetaken.sec
  end
  
  def laptime_in_seconds
    self.time_in_seconds / distance
  end
  
  def formatted_laptime
    laptime = self.laptime_in_seconds
    hours = laptime / (60 * 60 )
    minutes = (laptime - (hours * 60 * 60)) / 60
    seconds = laptime - (hours * 60 * 60) - (minutes * 60)
    
    "#{hours.to_s + ':' if hours != 0}#{minutes.to_s.rjust(2,'0') + ':' if minutes != 0}#{seconds.to_s.rjust(2,'0')}"
  end
  
  def self.sessions_for_user(user)
    self.find(:all, :conditions => "user_id = #{user.id}", :order => "workoutdate desc")
  end
  
  def self.top_five(user)
    self.find(:all, :conditions => "user_id = #{user.id}", :order => "workoutdate desc", :limit => 5)
  end
  
  def self.last_month(user, cardiotype = nil)
    startdate = Time.now - dhms2sec(28)
    if cardiotype.nil?
      self.find(:all, :conditions => "user_id = #{user.id} AND workoutdate > '#{startdate.to_formatted_s(:db)}'", :order => "workoutdate")
    else
      self.find(:all, :conditions => "user_id = #{user.id} AND cardiotype_id = #{cardiotype.id} AND workoutdate > '#{startdate.to_formatted_s(:db)}'", :order => "workoutdate")
    end
  end
end
