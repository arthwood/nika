class BlogController < ApplicationController

  verify :xhr => true, :render => {:text => 'Invalid request'}, :except => [:index, :list]
  verify :params => :id, :xhr => true, :render => {:text => 'Invalid request'}, 
    :except => [:index, :list, :new_item, :create_item, :create_comment]
  before_filter :superadmin_login_required, :except => [:index, :list, :show_comments, :new_comment, :create_comment]
  before_filter :set_blog_item, :only => [:edit_item, :update_item, :delete_item, :show_comments, :new_comment]
  before_filter :set_blog_comment, :only => [:edit_comment, :update_comment, :delete_comment]

  def index
    redirect_to :action => :list
  end

  def list
    if current_user.admin?
      conditions = nil
    else
      conditions = {:active => true}
      conditions.merge!(:public => true) unless current_user.friend? 
    end

    @blog_items = BlogItem.find(:all, :order => 'created_at DESC', :conditions => conditions)
    set_timezone
  end
  
  def new_item
    @blog_item = BlogItem.new(:user_id => current_user.id)
    @icons = normal_icons
    
    render :update do |p|
      p.replace_html 'new_blog_item', (render :partial => 'new_item')
      p.hide 'add_blog_item_link'
    end
  end
  
  def create_item
    @blog_item = BlogItem.create(params[:blog_item])
    success = @blog_item.valid?

    render :update do |p|
      if success
        p.insert_html :top, 'blog_list', (render :partial => 'blog_item', :object => @blog_item)
        p.replace_html 'new_blog_item', ''
        p.show 'add_blog_item_link'
      else
        p.replace_html 'new_blog_item', (render :partial => 'new_item')
      end
    end
  end

  def edit_item
    id = @blog_item.id

    render :update do |p|
      p.replace_html "blog_item_edit_#{id}", (render :partial => 'edit_item')
    end
  end
  
  def update_item
    blog_item_data = params[:blog_item]
    id = @blog_item.id
    success = @blog_item.update_attributes(blog_item_data)
    
    render :update do |p|
      if success
        p.replace_html "blog_item_content_#{id}", (render :partial => 'blog_item_data', :object => @blog_item)
        p.show "blog_item_content_#{id}"
        p.replace_html "blog_item_edit_#{id}", ''
        p.show "edit_blog_item_link_#{id}"
        style_class = 'blog-item' + (@blog_item.active ? '' : ' blog-item-inactive')
        p << "$('blog_item_#{id}').className ='#{style_class}'"
      else
        p.replace_html 'blog_item_edit_', (render :partial => 'edit_item')
      end
    end
  end
  
  def delete_item
    id = @blog_item.id
    @blog_item.destroy
    
    render :update do |p|
      p.remove 'blog_item_' + id.to_s
    end
  end
  
  def show_comments
    id = @blog_item.id
    @comments = current_user.admin? ? @blog_item.comments : @blog_item.comments_active
    set_timezone
    
    render :update do |p|
      p.hide "show_comments_link_#{id}"
      p.show "hide_comments_link_#{id}"
      p.replace_html "comments_#{id}", (render :partial => 'comment', :collection => @comments)
    end
  end
  
  def new_comment
    id = @blog_item.id
    @blog_comment = BlogComment.new(:blog_item_id => id, :user_id => current_user.id)
    
    render :update do |p|
      p.replace_html "new_comment_#{id}", (render :partial => 'new_comment')
      p.hide "add_comment_link_#{id}"
    end
  end

  def create_comment
    @blog_comment = BlogComment.create(params[:blog_comment])
    success = @blog_comment.valid?
    id = @blog_comment.blog_item_id
    comments = @blog_comment.blog_item.comments
    
    render :update do |p|
      if success
        p.show "comments_#{id}"
        p.replace_html "comments_#{id}", (render :partial => 'comment', :collection => comments)
        p.replace_html "new_comment_#{id}", ''
        p.show "add_comment_link_#{id}"
        p.replace_html "comments_num_#{id}", (render :partial => 'comments_num', :object => comments.size)
        p.hide "show_comments_link_#{id}"
        p.show "hide_comments_link_#{id}"
      else
        p.replace_html "new_comment_#{id}", (render :partial => 'new_comment')
      end
    end
  end

  def edit_comment
    id = @blog_comment.id

    render :update do |p|
      p.replace_html "blog_comment_edit_#{id}", (render :partial => 'edit_comment')
      p.hide "edit_comment_link_#{id}"
      p.hide "comment_content_#{id}"
    end
  end
  
  def update_comment
    blog_comment_data = params[:blog_comment]
    id = @blog_comment.id
    success = @blog_comment.update_attributes(blog_comment_data)
    set_timezone
    
    render :update do |p|
      if success
        p.replace_html "comment_content_#{id}", (render :partial => 'comment_data', :object => @blog_comment)
        p.show "comment_content_#{id}"
        p.replace_html "blog_comment_edit_#{id}", ''
        p.show "edit_comment_link_#{id}"
        style_class = 'blog-comment' + (@blog_comment.active ? '' : ' blog-comment-inactive')
        p << "$('blog_comment_#{id}').className ='#{style_class}'"
      else
        p.replace_html 'blog_item_edit_', (render :partial => 'edit_item')
      end
    end
  end
  
  def delete_comment
    comment_id = @blog_comment.id
    @blog_comment.destroy
    blog_item = @blog_comment.blog_item
    id = blog_item.id
    comments = blog_item.comments
    
    render :update do |p|
      p.replace_html "comments_num_#{id}", (render :partial => 'comments_num', :object => comments.size)
      p.remove "blog_comment_#{comment_id}"
      
      if comments.empty?
        p.hide "comments_#{id}"
        p.hide "hide_comments_link_#{id}"
      end
    end
  end
  
  private
    def set_blog_item
      @blog_item = BlogItem.find(params[:id])
    end

    def set_blog_comment
      @blog_comment = BlogComment.find(params[:id])
    end
    
    def normal_icons
      Icon.find(:all, :conditions => {:thumbnail => 'normal'})
    end
    
    def set_timezone
      @timezone = logged_in? && current_user.timezone && TimeZone[current_user.timezone]
    end
end