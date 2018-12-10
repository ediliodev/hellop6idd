require 'test_helper'

class ControlspnntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlspnnt = controlspnnts(:one)
  end

  test "should get index" do
    get controlspnnts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlspnnt_url
    assert_response :success
  end

  test "should create controlspnnt" do
    assert_difference('Controlspnnt.count') do
      post controlspnnts_url, params: { controlspnnt: { limite: @controlspnnt.limite, n1: @controlspnnt.n1, n2: @controlspnnt.n2, siglas: @controlspnnt.siglas, vendida: @controlspnnt.vendida } }
    end

    assert_redirected_to controlspnnt_url(Controlspnnt.last)
  end

  test "should show controlspnnt" do
    get controlspnnt_url(@controlspnnt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlspnnt_url(@controlspnnt)
    assert_response :success
  end

  test "should update controlspnnt" do
    patch controlspnnt_url(@controlspnnt), params: { controlspnnt: { limite: @controlspnnt.limite, n1: @controlspnnt.n1, n2: @controlspnnt.n2, siglas: @controlspnnt.siglas, vendida: @controlspnnt.vendida } }
    assert_redirected_to controlspnnt_url(@controlspnnt)
  end

  test "should destroy controlspnnt" do
    assert_difference('Controlspnnt.count', -1) do
      delete controlspnnt_url(@controlspnnt)
    end

    assert_redirected_to controlspnnts_url
  end
end
