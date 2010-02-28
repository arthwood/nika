class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  include AuthenticatedSystem

  layout 'main'

  before_filter :login_from_cookie
  
  def flash_notice(msg_)
    flash_message(:notice, msg_)
  end
  
  def flash_error(msg_)
    flash_message(:error, msg_)
  end
  
  def flash_message(type_, msg_)
    flash[type_] = msg_
  end
  
  def remote_render_partial(element_, partial_)
    render :update do |p|
      p.replace_html element_, render(:partial => partial_)
    end
  end
  
  def remote_render_collection(element_, partial_, collection_)
    render :update do |p|
      p.replace_html element_, render(:partial => partial_, :collection => collection_)
    end
  end
end
