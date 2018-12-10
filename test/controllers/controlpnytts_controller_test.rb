require 'test_helper'

class ControlpnyttsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlpnytt = controlpnytts(:one)
  end

  test "should get index" do
    get controlpnytts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlpnytt_url
    assert_response :success
  end

  test "should create controlpnytt" do
    assert_difference('Controlpnytt.count') do
      post controlpnytts_url, params: { controlpnytt: { limite: @controlpnytt.limite, n1: @controlpnytt.n1, n2: @controlpnytt.n2, siglas: @controlpnytt.siglas, vendida: @controlpnytt.vendida } }
    end

    assert_redirected_to controlpnytt_url(Controlpnytt.last)
  end

  test "should show controlpnytt" do
    get controlpnytt_url(@controlpnytt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlpnytt_url(@controlpnytt)
    assert_response :success
  end

  test "should update controlpnytt" do
    patch controlpnytt_url(@controlpnytt), params: { controlpnytt: { limite: @controlpnytt.limite, n1: @controlpnytt.n1, n2: @controlpnytt.n2, siglas: @controlpnytt.siglas, vendida: @controlpnytt.vendida } }
    assert_redirected_to controlpnytt_url(@controlpnytt)
  end

  test "should destroy controlpnytt" do
    assert_difference('Controlpnytt.count', -1) do
      delete controlpnytt_url(@controlpnytt)
    end

    assert_redirected_to controlpnytts_url
  end
end
