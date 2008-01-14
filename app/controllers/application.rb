# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8fd1a828bda7fd934f095eb3ce852f10'
  
  def source_url
    session[:head] = self.controller_name if session[:head] == nil
    self.url_for(:controller => session[:head], :action => "index")
  end
end
