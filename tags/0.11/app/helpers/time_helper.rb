module TimeHelper
  def time_from_text(text)
    time = nil
    r = /((\d+):)?((\d+):)?(\d+)/
    m = r.match(text)
    if (!m.nil?)
      colonCount = m[0].count(":")
      timeString = ("00:" * (2 - colonCount)) + m[0]
      begin
        time = Time.parse(timeString) if (colonCount >= 0 && colonCount <= 2)
      rescue
        time = nil
      end
    end
    time
  end
end

class Time
  def time_as_text
    r = ""
    r += self.hour.to_s.rjust(2,"0") + ":" if (self.hour != 0)
    r += self.min.to_s.rjust(2,"0") + ":" if (self.min != 0)
    r += self.sec.to_s.rjust(2,"0")
    r
  end
end

class Date
  def date_as_text
    self.strftime("%A %d %B")
  end
end

Time.extend TimeHelper