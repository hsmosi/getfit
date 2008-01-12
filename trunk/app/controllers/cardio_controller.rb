class CardioController < ApplicationController
  before_filter :login_required
  
  def index
    @currentsession = nil
    @sessions = Cardiosession.find(:all, :order => "workoutdate desc")
  end
  
  def edit
    @cardiotypes = Cardiotype.find(:all)
    if params[:currentsession].nil?
      @currentsession = Cardiosession.find(params[:sessionid])
    else
      @currentsession = Cardiosession.update(params[:currentsession][:id], params[:currentsession])
      redirect_to :action => "index" if (@currentsession.valid?)
    end
  end
  
  def new
    @cardiotypes = Cardiotype.find(:all)
    if params[:currentsession].nil?
      @currentsession = Cardiosession.new
      @currentsession.workoutdate = Date.today
    else
      @currentsession = Cardiosession.new(params[:currentsession])
      @currentsession.user = self.current_user
      if @currentsession.valid?
        @currentsession.save
        redirect_to :action => "index"
      end
    end
  end
  
  def delete
    Cardiosession.delete(params[:sessionid])
    redirect_to :action => "index"
  end
end
