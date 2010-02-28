class IconsController < ApplicationController
  before_filter :superadmin_login_required
  verify :params => :id, :xhr => true, :render => {:text => 'Invalid request'}, :only => [:delete]
  before_filter :set_icon, :only => [:delete]
  
  def index
    @icon = Icon.new
    @icons = Icon.all
  end
  
  def create
    @icon = Icon.create(params[:icon])
    @icons = Icon.all
    
    render :action => :index
  end
  
  def delete
    id = @icon.id
    @icon.destroy
    
    render :update do |p|
      p.remove "icon_#{id}"
      p.hide :icons if Icon.count == 0
    end
  end
  
  private
  
  def set_icon
    @icon = Icon.find(params[:id])
  end
end
