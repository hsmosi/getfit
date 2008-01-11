module CardioHelper
  def oval_button_to text, options
    link = url_for(options)
    "<a class='ovalbutton' href='#{link}'><span>#{text}</span></a>"
  end
  
  def oval_button_to_script text, script
    "<a class='ovalbutton' href='#' onclick=\"#{script}\"><span>#{text}</span></a>"
  end
end
