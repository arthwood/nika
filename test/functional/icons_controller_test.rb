require File.dirname(__FILE__) + '/../test_helper'
require 'icons_controller'

# Re-raise errors caught by the controller.
class IconsController; def rescue_action(e) raise e end; end

class IconsControllerTest < Test::Unit::TestCase
  def setup
    @controller = IconsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
