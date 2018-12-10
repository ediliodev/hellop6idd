require 'test_helper'

class ControlqnntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlqnnt = controlqnnts(:one)
  end

  test "should get index" do
    get controlqnnts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlqnnt_url
    assert_response :success
  end

  test "should create controlqnnt" do
    assert_difference('Controlqnnt.count') do
      post controlqnnts_url, params: { controlqnnt: { limite: @controlqnnt.limite, numero: @controlqnnt.numero, vendida: @controlqnnt.vendida } }
    end

    assert_redirected_to controlqnnt_url(Controlqnnt.last)
  end

  test "should show controlqnnt" do
    get controlqnnt_url(@controlqnnt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlqnnt_url(@controlqnnt)
    assert_response :success
  end

  test "should update controlqnnt" do
    patch controlqnnt_url(@controlqnnt), params: { controlqnnt: { limite: @controlqnnt.limite, numero: @controlqnnt.numero, vendida: @controlqnnt.vendida } }
    assert_redirected_to controlqnnt_url(@controlqnnt)
  end

  test "should destroy controlqnnt" do
    assert_difference('Controlqnnt.count', -1) do
      delete controlqnnt_url(@controlqnnt)
    end

    assert_redirected_to controlqnnts_url
  end
end
