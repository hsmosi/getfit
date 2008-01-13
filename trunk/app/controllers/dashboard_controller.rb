class DashboardController < ApplicationController
  before_filter :login_required
  layout "site"
  
  def index
    @cardioSessions = Cardiosession.top_five(self.current_user)
    @bodyStats = Body.top_five(self.current_user)
  end
  
  def cardioGraphData
    @cardioSessions = Cardiosession.last_month(self.current_user)
    @minValue = (@cardioSessions.min { |a,b| a.time_in_seconds <=> b.time_in_seconds }).time_in_seconds - 30
    @maxValue = (@cardioSessions.max { |a,b| a.time_in_seconds <=> b.time_in_seconds }).time_in_seconds + 30
    render :layout => false
  end
  
  def bodyGraphData
    @bodyMetrics = Body.last_month(self.current_user)
    @minValue = (@bodyMetrics.min { |a,b| a.weight <=> b.weight }).weight - 5
    @maxValue = (@bodyMetrics.max { |a,b| a.weight <=> b.weight }).weight + 5
    render :layout => false
  end
end
