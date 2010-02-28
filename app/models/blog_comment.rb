class BlogComment < ActiveRecord::Base
  belongs_to :blog_item
  belongs_to :user
  alias_method :owner, :user
  
  def user
    owner || Visitor.new
  end

  protected
    def before_validation
      (self.active = active.nil? ? false : active)
      true
    end
end
