require 'test_helper'

class ManageuserbtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manageuserbt = manageuserbts(:one)
  end

  test "should get index" do
    get manageuserbts_url
    assert_response :success
  end

  test "should get new" do
    get new_manageuserbt_url
    assert_response :success
  end

  test "should create manageuserbt" do
    assert_difference('Manageuserbt.count') do
      post manageuserbts_url, params: { manageuserbt: { activo?: @manageuserbt.activo?, email: @manageuserbt.email, password: @manageuserbt.password } }
    end

    assert_redirected_to manageuserbt_url(Manageuserbt.last)
  end

  test "should show manageuserbt" do
    get manageuserbt_url(@manageuserbt)
    assert_response :success
  end

  test "should get edit" do
    get edit_manageuserbt_url(@manageuserbt)
    assert_response :success
  end

  test "should update manageuserbt" do
    patch manageuserbt_url(@manageuserbt), params: { manageuserbt: { activo?: @manageuserbt.activo?, email: @manageuserbt.email, password: @manageuserbt.password } }
    assert_redirected_to manageuserbt_url(@manageuserbt)
  end

  test "should destroy manageuserbt" do
    assert_difference('Manageuserbt.count', -1) do
      delete manageuserbt_url(@manageuserbt)
    end

    assert_redirected_to manageuserbts_url
  end
end
