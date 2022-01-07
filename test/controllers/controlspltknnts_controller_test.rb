require 'test_helper'

class ControlspltknntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlspltknnt = controlspltknnts(:one)
  end

  test "should get index" do
    get controlspltknnts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlspltknnt_url
    assert_response :success
  end

  test "should create controlspltknnt" do
    assert_difference('Controlspltknnt.count') do
      post controlspltknnts_url, params: { controlspltknnt: { limite: @controlspltknnt.limite, n1: @controlspltknnt.n1, n2: @controlspltknnt.n2, siglas: @controlspltknnt.siglas, vendida: @controlspltknnt.vendida } }
    end

    assert_redirected_to controlspltknnt_url(Controlspltknnt.last)
  end

  test "should show controlspltknnt" do
    get controlspltknnt_url(@controlspltknnt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlspltknnt_url(@controlspltknnt)
    assert_response :success
  end

  test "should update controlspltknnt" do
    patch controlspltknnt_url(@controlspltknnt), params: { controlspltknnt: { limite: @controlspltknnt.limite, n1: @controlspltknnt.n1, n2: @controlspltknnt.n2, siglas: @controlspltknnt.siglas, vendida: @controlspltknnt.vendida } }
    assert_redirected_to controlspltknnt_url(@controlspltknnt)
  end

  test "should destroy controlspltknnt" do
    assert_difference('Controlspltknnt.count', -1) do
      delete controlspltknnt_url(@controlspltknnt)
    end

    assert_redirected_to controlspltknnts_url
  end
end
