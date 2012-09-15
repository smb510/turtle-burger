require 'test_helper'

class WorkoutControllerTest < ActionController::TestCase
  test "should get assemble" do
    get :assemble
    assert_response :success
  end

end
