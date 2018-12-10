require 'test_helper'

class MenutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menut = menuts(:one)
  end

  test "should get index" do
    get menuts_url
    assert_response :success
  end

  test "should get new" do
    get new_menut_url
    assert_response :success
  end

  test "should create menut" do
    assert_difference('Menut.count') do
      post menuts_url, params: { menut: {  } }
    end

    assert_redirected_to menut_url(Menut.last)
  end

  test "should show menut" do
    get menut_url(@menut)
    assert_response :success
  end

  test "should get edit" do
    get edit_menut_url(@menut)
    assert_response :success
  end

  test "should update menut" do
    patch menut_url(@menut), params: { menut: {  } }
    assert_redirected_to menut_url(@menut)
  end

  test "should destroy menut" do
    assert_difference('Menut.count', -1) do
      delete menut_url(@menut)
    end

    assert_redirected_to menuts_url
  end
end
