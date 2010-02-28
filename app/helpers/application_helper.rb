# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  MENUS = ['/layouts/visitor_menu', '/layouts/admin_menu', '/layouts/friend_menu', '/layouts/user_menu']
  
  def role_to_menu(role_id_)
    MENUS[role_id_]
  end
  
  def verbalize_boolean(boolean_)
    boolean_ ? 'yes' : 'no'
  end

  def time_format(time)
    time.strftime("%d-%m-%Y %H:%M")
  end
  
  def preserve_breaks(text_)
    text_.gsub(/\r\n?/, "\n").gsub(/\n/, '<br />')
  end

  def can_add_blog_items?
    current_user.superadmin?
  end
  
  def can_edit_blog_items?
    current_user.superadmin?
  end
  
  def can_delete_blog_items?
    current_user.superadmin?
  end
  
  def can_add_blog_comments?
    true
  end
  
  def can_edit_blog_comments?
    current_user.superadmin?
  end
  
  def can_delete_blog_comments?
    current_user.superadmin?
  end
  
  def singular_or_plural(n_, word_)
    (n_ == 1) ? word_ : word_.pluralize
  end
  
  def ajax_indicator(hash_, element_)
    hash_[:before] = (hash_[:before].nil? ? '' : hash_[:before] + ';') + "insert_ajax_indicator($('#{element_}'))"
    hash_
  end
  
  def hide_if_empty(items_)
    "display: #{items_.empty? ? 'none' : ''}"
  end
end