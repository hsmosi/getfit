class Cardiosession < ActiveRecord::Base
  belongs_to :user
  validates_numericality_of :distance, :message => "Distance must be a number", :allow_nil => true
  validates_presence_of :distance, :message => "Distance is required"
  validates_presence_of :timetaken, :message => "Time taken is required"
  validates_presence_of :workoutdate, :message => "Workout date is required"
  
  def timetakenastext=(text)
    self.timetaken = nil
    r = /((\d+):)?((\d+):)?(\d+)/
    m = r.match(text)
    if (!m.nil?)
      colonCount = m[0].count(":")
      timeString = ("00:" * (2 - colonCount)) + m[0]
      self.timetaken = Time.parse(timeString) if (colonCount >= 0 && colonCount <= 2) rescue self.timetaken = nil
    end
  end
  
  def timetakenastext
    r = ""
    if (!self.timetaken.nil?)
      r += self.timetaken.hour.to_s.rjust(2,"0") + ":" if (self.timetaken.hour != 0)
      r += self.timetaken.min.to_s.rjust(2,"0") + ":" if (self.timetaken.min != 0)
      r += self.timetaken.sec.to_s.rjust(2,"0")
    end
    r
  end
end
