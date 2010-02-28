class GalleryController < ApplicationController
  verify :xhr => true, :only => [:on_new_photoset, :create_photo_set, :on_photo_set_item], 
    :add_flash => {:error => 'Invalid request!'}, :redirect_to => {:action => :index}
  verify :params => :photo_set, :only => :create_photo_set, 
    :add_flash => {:error => 'Invalid request! (photo_set param required)'}, :redirect_to => {:action => :index}
  verify :params => :photo, :only => :create_photo,
    :add_flash => {:error => 'Invalid request! (photo param required)'}, :redirect_to => {:action => :index}
  verify :params => :id, :only => :on_photo_set_item, 
    :add_flash => {:error => 'Invalid request! (id param required)'}, :redirect_to => {:action => :index}

  def index
    @photo_sets = PhotoSet.find :all
    @uncategorized_photos_num = Photo.count(:conditions => {:photo_set_id => nil})
  end
  
  def on_new_photoset
    @photo_set = PhotoSet.new

    remote_render_partial(:new_photoset_form, 'new_photo_set_form')
  end
  
  def create_photo_set
    PhotoSet.create(params[:photo_set])

    render :update do |p|
      p.replace_html :photo_sets, render(:partial => 'photo_set_item', :collection => PhotoSet.find(:all))
      p << "$('new_photo_set_link').show()"
    end
  end
  
  def on_photo_set_item
    @photo_set = PhotoSet.find(params[:id])
    @photos = @photo_set.photos

    remote_render_collection(:photos, 'photo_item', @photos)
  end

  def on_uncategorized_photo_set_item
    @photos = Photo.find(:all, :conditions => {:photo_set_id => nil, :parent_id => nil})

    remote_render_collection(:photos, 'photo_item', @photos)
  end

  def on_new_photo
    @photo = Photo.new
    @photo_set_options = [['Select Photoset', nil]] + PhotoSet.options

    remote_render_partial(:new_photo_form, 'new_photo_form')
  end

  def create_photo
    @photo = Photo.create(params[:photo])
    flash_notice 'Photo successfully created'
    p @photo.errors.full_messages
    redirect_to :action => :index
  end
end
