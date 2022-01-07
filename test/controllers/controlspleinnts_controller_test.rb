require 'test_helper'

class ControlspleinntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlspleinnt = controlspleinnts(:one)
  end

  test "should get index" do
    get controlspleinnts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlspleinnt_url
    assert_response :success
  end

  test "should create controlspleinnt" do
    assert_difference('Controlspleinnt.count') do
      post controlspleinnts_url, params: { controlspleinnt: { limite: @controlspleinnt.limite, n1: @controlspleinnt.n1, n2: @controlspleinnt.n2, siglas: @controlspleinnt.siglas, vendida: @controlspleinnt.vendida } }
    end

    assert_redirected_to controlspleinnt_url(Controlspleinnt.last)
  end

  test "should show controlspleinnt" do
    get controlspleinnt_url(@controlspleinnt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlspleinnt_url(@controlspleinnt)
    assert_response :success
  end

  test "should update controlspleinnt" do
    patch controlspleinnt_url(@controlspleinnt), params: { controlspleinnt: { limite: @controlspleinnt.limite, n1: @controlspleinnt.n1, n2: @controlspleinnt.n2, siglas: @controlspleinnt.siglas, vendida: @controlspleinnt.vendida } }
    assert_redirected_to controlspleinnt_url(@controlspleinnt)
  end

  test "should destroy controlspleinnt" do
    assert_difference('Controlspleinnt.count', -1) do
      delete controlspleinnt_url(@controlspleinnt)
    end

    assert_redirected_to controlspleinnts_url
  end
end
