require 'test_helper'

class ControlpgmtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlpgmt = controlpgmts(:one)
  end

  test "should get index" do
    get controlpgmts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlpgmt_url
    assert_response :success
  end

  test "should create controlpgmt" do
    assert_difference('Controlpgmt.count') do
      post controlpgmts_url, params: { controlpgmt: { limite: @controlpgmt.limite, n1: @controlpgmt.n1, n2: @controlpgmt.n2, siglas: @controlpgmt.siglas, vendida: @controlpgmt.vendida } }
    end

    assert_redirected_to controlpgmt_url(Controlpgmt.last)
  end

  test "should show controlpgmt" do
    get controlpgmt_url(@controlpgmt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlpgmt_url(@controlpgmt)
    assert_response :success
  end

  test "should update controlpgmt" do
    patch controlpgmt_url(@controlpgmt), params: { controlpgmt: { limite: @controlpgmt.limite, n1: @controlpgmt.n1, n2: @controlpgmt.n2, siglas: @controlpgmt.siglas, vendida: @controlpgmt.vendida } }
    assert_redirected_to controlpgmt_url(@controlpgmt)
  end

  test "should destroy controlpgmt" do
    assert_difference('Controlpgmt.count', -1) do
      delete controlpgmt_url(@controlpgmt)
    end

    assert_redirected_to controlpgmts_url
  end
end
