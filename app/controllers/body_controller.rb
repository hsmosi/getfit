class BodyController < ApplicationController
  before_filter :login_required
  layout "site"

  def index
    session[:head] = "body"
    @bodies = Body.bodies_for_user(self.current_user)
  end
  
  def edit
    @back = self.source_url
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
      redirect_to @back if (@currentbody.valid?)
    end
  end
  
  def new
    @back = self.source_url
    if params[:currentbody].nil?
      @currentbody = Body.new
      @currentbody.measurementdate = Date.today
    else
      @currentbody = Body.new(params[:currentbody])
      @currentbody.user = self.current_user
      if @currentbody.valid?
        @currentbody.save
        redirect_to @back
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
    redirect_to self.source_url
  end
end
