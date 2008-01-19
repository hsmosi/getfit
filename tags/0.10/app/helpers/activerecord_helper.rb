module ActiverecordHelper
  def dhms2sec(days, hrs=0, min=0, sec=0)
      days*86400 + hrs*3600 + min*60 + sec
  end
end

ActiveRecord::Base.extend ActiverecordHelper