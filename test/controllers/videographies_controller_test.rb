require 'test_helper'

class VideographiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get answer" do
    get :answer
    assert_response :success
  end

end
