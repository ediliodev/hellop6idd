require 'test_helper'

class ControlpnntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlpnnt = controlpnnts(:one)
  end

  test "should get index" do
    get controlpnnts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlpnnt_url
    assert_response :success
  end

  test "should create controlpnnt" do
    assert_difference('Controlpnnt.count') do
      post controlpnnts_url, params: { controlpnnt: { limite: @controlpnnt.limite, n1: @controlpnnt.n1, n2: @controlpnnt.n2, siglas: @controlpnnt.siglas, vendida: @controlpnnt.vendida } }
    end

    assert_redirected_to controlpnnt_url(Controlpnnt.last)
  end

  test "should show controlpnnt" do
    get controlpnnt_url(@controlpnnt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlpnnt_url(@controlpnnt)
    assert_response :success
  end

  test "should update controlpnnt" do
    patch controlpnnt_url(@controlpnnt), params: { controlpnnt: { limite: @controlpnnt.limite, n1: @controlpnnt.n1, n2: @controlpnnt.n2, siglas: @controlpnnt.siglas, vendida: @controlpnnt.vendida } }
    assert_redirected_to controlpnnt_url(@controlpnnt)
  end

  test "should destroy controlpnnt" do
    assert_difference('Controlpnnt.count', -1) do
      delete controlpnnt_url(@controlpnnt)
    end

    assert_redirected_to controlpnnts_url
  end
end
