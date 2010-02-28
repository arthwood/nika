class UsersController < ApplicationController
  before_filter :admin_login_required, :only => [:list, :delete, :new, :edit, :create, :update]
  before_filter :login_required, :only => [:profile, :edit_profile, :update_profile]
  
  verify :params => :id, :xhr => true, :render => {:text => 'Not valid request'}, :only => [:delete]
  verify :params => :id, :xhr => false, :render => {:text => 'Not valid request'}, :only => [:edit, :update]
  verify :method => :post, :render => {:text => 'Not valid request'}, :only => [:onlogin, :onsignup, :create, :update, :update_profile]

  def index
    redirect_to :action => :list
  end
  
  def onlogin
    self.current_user = User.authenticate(params[:login], params[:password])

    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me
        cookies[:auth_token] = { :value => current_user.remember_token , :expires => current_user.remember_token_expires_at }
      end
      flash_notice 'Logged in successfully'
      redirect_back_or_default(current_user.homepage)
    else
      flash_error 'Invalid login or password'
      render :action => :login
    end
  end

  def onsignup
    user_data = params[:user]
    user_data.delete :active
    @user = User.new(user_data)
    @user.save!
    redirect_back_or_default(:controller => :home)
    flash_notice "Thanks for signing up! You will be notified about account activation"
  rescue ActiveRecord::RecordInvalid
    render :action => :signup
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash_notice "You have been logged out."
    redirect_back_or_default(:controller => :home)
  end
  
  def list
    @users = User.find :all, :include => :role
    @role_options = Role.options
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    user_data = params[:user]
    @user = User.new(user_data)
    @user.save!
    redirect_to(:action => :list)
    flash_notice "User #{@user.name} successfully created!"
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes!(params[:user])
    redirect_to(:action => :list)
    flash_notice "User #{@user.name} successfully updated!"
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end

  def delete
    user_id = params[:id]
    user = User.find(user_id)
    user_name = user.name
    
    if user == User.find_by_login(ADMIN[:login])
      render :update do |p|
        p << "setFlashError('Cannot delete superadmin!')"
      end
      return
    end
    
    user.destroy
    
    render :update do |p|
      p << "$('user_' + #{user_id}).remove()"
      p << "setFlashNotice('User #{user_name} successfully deleted')"
    end
  end
  
  def profile
    @user = current_user
    @timezone = @user.timezone
    
    if @timezone
      utc_offset = ActiveSupport::TimeZone::ZONES_MAP[@timezone].utc_offset.to_i
      @timezones = ActiveSupport::TimeZone.all.select {|i| i.utc_offset == utc_offset}
    end
  end
  
  def edit_profile
    @user = current_user
  end
  
  def update_profile
    @user = current_user
    @user.update_attributes(params[:user])
    
    flash_notice "Your profile has been successfully updated!"
    
    redirect_to :action => :profile
  end
end
