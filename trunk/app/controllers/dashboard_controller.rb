class DashboardController < ApplicationController
  before_filter :login_required
  layout "site"
  
  def index
    session[:head] = self.controller_name
    
    @cardioSessions = Cardiosession.top_five(self.current_user)
    @bodyStats = Body.top_five(self.current_user)
    @activegoals = Goal.all_active(self.current_user)
    @completedgoals = Goal.all_completed(self.current_user)
    
    if (params[:graphtype].nil?)
      @graphtype = "Run"
    else
      @graphtype = params[:graphtype]
    end
    
    case @graphtype
      when "Run"
        @graphCaption = "Recent Runs - Laptime in Seconds"
        
      when "Swim"
        @graphCaption = "Recent Swims - Laptime in Seconds"
        
      when "Cycle"
        @graphCaption = "Recent Cycling - Laptime in Seconds"
      
      when "Weight"
        @graphCaption = "Recent Weigh-Ins"
    end
    
    if @graphtype == "Weight"
      @graphdataurl = url_for(:action=>"bodyGraphData", :graphtype => @graphtype)
    else
      @graphdataurl = url_for(:action=>"cardioGraphData", :graphtype => @graphtype)
    end
  end
  
  def cardioGraphData
    cardioType = Cardiotype.find_by_description(params[:graphtype])
    @cardioSessions = Cardiosession.last_month(self.current_user, cardioType)
    @minValue = (@cardioSessions.min { |a,b| a.laptime_in_seconds <=> b.laptime_in_seconds }).laptime_in_seconds - 10
    @maxValue = (@cardioSessions.max { |a,b| a.laptime_in_seconds <=> b.laptime_in_seconds }).laptime_in_seconds + 10
    render :layout => false
  end
  
  def bodyGraphData
    @bodyMetrics = Body.last_month(self.current_user)
    @minValue = (@bodyMetrics.min { |a,b| a.weight <=> b.weight }).weight - 5
    @maxValue = (@bodyMetrics.max { |a,b| a.weight <=> b.weight }).weight + 5
    render :layout => false
  end
end
