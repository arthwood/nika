class BlogItem < ActiveRecord::Base
  belongs_to :icon
  has_many :comments, :class_name => 'BlogComment', :include => :user, :dependent => :destroy, :order => 'blog_comments.created_at DESC'
  
  validates_presence_of     :title, :body, :user_id
  validates_inclusion_of    :active, :in => [true, false]

  def has_icon?
    !icon.nil?
  end

  def comments_active
    comments.select {|i| i.active}
  end
  
  protected
    def before_validation
      (self.active = active.nil? ? true : active)
      true
    end
end