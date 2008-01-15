# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def dhms2sec(days, hrs=0, min=0, sec=0)
      days*86400 + hrs*3600 + min*60 + sec
  end
end