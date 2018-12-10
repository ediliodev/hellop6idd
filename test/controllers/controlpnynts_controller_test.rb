require 'test_helper'

class ControlpnyntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlpnynt = controlpnynts(:one)
  end

  test "should get index" do
    get controlpnynts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlpnynt_url
    assert_response :success
  end

  test "should create controlpnynt" do
    assert_difference('Controlpnynt.count') do
      post controlpnynts_url, params: { controlpnynt: { limite: @controlpnynt.limite, n1: @controlpnynt.n1, n2: @controlpnynt.n2, siglas: @controlpnynt.siglas, vendida: @controlpnynt.vendida } }
    end

    assert_redirected_to controlpnynt_url(Controlpnynt.last)
  end

  test "should show controlpnynt" do
    get controlpnynt_url(@controlpnynt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlpnynt_url(@controlpnynt)
    assert_response :success
  end

  test "should update controlpnynt" do
    patch controlpnynt_url(@controlpnynt), params: { controlpnynt: { limite: @controlpnynt.limite, n1: @controlpnynt.n1, n2: @controlpnynt.n2, siglas: @controlpnynt.siglas, vendida: @controlpnynt.vendida } }
    assert_redirected_to controlpnynt_url(@controlpnynt)
  end

  test "should destroy controlpnynt" do
    assert_difference('Controlpnynt.count', -1) do
      delete controlpnynt_url(@controlpnynt)
    end

    assert_redirected_to controlpnynts_url
  end
end
