class GoalController < ApplicationController
  layout "site"
  
  def index
    session[:head] = "goal"
    @activegoals = Goal.all_active(self.current_user)
    @completedgoals = Goal.all_completed(self.current_user) # all goals passed the deadline
  end
  
  def new
    @goaltypes = Goaltype.all
    @cardiotypes = Cardiotype.all

    if params[:goal].nil?
      @goal = Goal.new
      @goal.target_date = Date.today + 28.days
    else
      @goal = Goal.new(params[:goal])
      @goal.user = self.current_user
      if @goal.valid?
        @goal.save
        redirect_to self.source_url
        return
      end
    end
    
    @targetWeightStyle = "display: none;"
    @targetTimeStyle = "display: none;"
    @targetDistanceStyle = "display: none;"
    @targetTypeStyle = "display: none;"
    
    case @goal.goaltype.focus
      when "G"
        @targetWeightStyle = "display: block;"
      when "L"
        @targetWeightStyle = "display: block;"
      when "T"
        @targetTimeStyle = "display: block;"
        @targetTypeStyle = "display: block;"
      when "D"
        @targetDistanceStyle = "display: block;"
        @targetTypeStyle = "display: block;"
    end
  end
  
  def delete
    begin
      goal = Goal.find(params[:goalid])
    rescue
      redirect_to :action => "unauthorised"
      return
    end
    
    if goal.user != self.current_user
      redirect_to :action => "unauthorised"
      return
    end
    
    Goal.delete(goal.id)
    redirect_to self.source_url
  end
end
