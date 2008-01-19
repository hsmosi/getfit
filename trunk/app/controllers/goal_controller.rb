class GoalController < ApplicationController
  layout "site"
  
  def index
    @activegoals = Goal.all_active(self.current_user)
    @completegoals = Goal.all_completed(self.current_user)
  end
  
  def new
    @goaltypes = Goaltype.all
    @cardiotypes = Cardiotype.all

    if params[:goal].nil?
      @goal = Goal.new
      @goal.target_date = Date.today + 28.days
    else
      @goal = Goal.new(params[:goal])
      
    end
    
    @targetWeightStyle = "display: none;"
    @targetTimeStyle = "display: none;"
    @targetDistanceStyle = "display: none;"
    @targetTypeStyle = "display: none;"
    
    case @goal.goaltype.focus
      when "W"
        @targetWeightStyle = "display: block;"
      when "T"
        @targetTimeStyle = "display: block;"
        @targetTypeStyle = "display: block;"
      when "D"
        @targetDistanceStyle = "display: block;"
        @targetTypeStyle = "display: block;"
    end

  end
end
