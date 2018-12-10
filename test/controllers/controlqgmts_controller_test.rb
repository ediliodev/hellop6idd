require 'test_helper'

class ControlqgmtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlqgmt = controlqgmts(:one)
  end

  test "should get index" do
    get controlqgmts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlqgmt_url
    assert_response :success
  end

  test "should create controlqgmt" do
    assert_difference('Controlqgmt.count') do
      post controlqgmts_url, params: { controlqgmt: { limite: @controlqgmt.limite, numero: @controlqgmt.numero, vendida: @controlqgmt.vendida } }
    end

    assert_redirected_to controlqgmt_url(Controlqgmt.last)
  end

  test "should show controlqgmt" do
    get controlqgmt_url(@controlqgmt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlqgmt_url(@controlqgmt)
    assert_response :success
  end

  test "should update controlqgmt" do
    patch controlqgmt_url(@controlqgmt), params: { controlqgmt: { limite: @controlqgmt.limite, numero: @controlqgmt.numero, vendida: @controlqgmt.vendida } }
    assert_redirected_to controlqgmt_url(@controlqgmt)
  end

  test "should destroy controlqgmt" do
    assert_difference('Controlqgmt.count', -1) do
      delete controlqgmt_url(@controlqgmt)
    end

    assert_redirected_to controlqgmts_url
  end
end
