class BodyController < ApplicationController
  before_filter :login_required
  layout "cardio"

  def index
    @bodies = Body.bodies_for_user(self.current_user)
  end
  
  def edit
    if params[:currentbody].nil?
      begin
        @currentbody = Body.find(params[:bodyid])
      rescue
        redirect_to :action => "unauthorised"
        return
      end
      
      if @currentbody.user != self.current_user
        @currentbody = nil
        redirect_to :action => "unauthorised"
      end
    else
      @currentbody = Body.update(params[:currentbody][:id], params[:currentbody])
      redirect_to :action => "index" if (@currentbody.valid?)
    end
  end
  
  def new
    if params[:currentbody].nil?
      @currentbody = Body.new
      @currentbody.measurementdate = Date.today
    else
      @currentbody = Body.new(params[:currentbody])
      @currentbody.user = self.current_user
      if @currentbody.valid?
        @currentbody.save
        redirect_to :action => "index"
      end
    end
  end
  
  def delete
    begin
      body = Body.find(params[:bodyid])
    rescue
      redirect_to :action => "unauthorised"
      return
    end
    
    if body.user != self.current_user
      redirect_to :action => "unauthorised"
      return
    end
    
    Body.delete(body.id)
    redirect_to :action => "index"
  end
end
