class CardioController < ApplicationController
  before_filter :login_required
  
  def index
    @session = nil
    @sessions = Cardiosession.find(:all, :order => "workoutdate desc")
  end
  
  def edit
    if params[:session].nil?
      @session = Cardiosession.find(params[:sessionid])
    else
      @session = Cardiosession.new(params[:session])
      if (@session.valid?)
        @session.save
        redirect_to :action => "index"
      end
    end
  end
  
  def new
    if params[:session] == nil
      @session = Cardiosession.new
      @session.workoutdate = Date.today
    else
      @session = Cardiosession.new(params[:session])
      @session.user = self.current_user
      if @session.valid?
        @session.save
        redirect_to :action => "index"
      end
    end
  end
  
  def delete
    Cardiosession.delete(params[:sessionid])
    redirect_to :action => "index"
  end
end
