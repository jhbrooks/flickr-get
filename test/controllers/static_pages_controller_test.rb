require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get home with valid search" do
    get :home, id: 2
    assert_response :success
    assert_select "div.alert-success"
  end

  test "should get home with valid search finding no public photos" do
    get :home, id: 1
    assert_response :success
    assert_select "div.alert-info"
  end

  test "should get home with invalid search" do
    get :home, id: "highly_improbable_username"
    assert_response :success
    assert_select "div.alert-danger"
  end
end
