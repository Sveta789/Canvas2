require 'test_helper'

class RatingsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get answer" do
    get :answer
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
