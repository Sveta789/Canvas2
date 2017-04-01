require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  test "should get destroy" do
    get :destroy
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
