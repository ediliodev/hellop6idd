require 'test_helper'

class ControlqnyntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlqnynt = controlqnynts(:one)
  end

  test "should get index" do
    get controlqnynts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlqnynt_url
    assert_response :success
  end

  test "should create controlqnynt" do
    assert_difference('Controlqnynt.count') do
      post controlqnynts_url, params: { controlqnynt: { limite: @controlqnynt.limite, numero: @controlqnynt.numero, vendida: @controlqnynt.vendida } }
    end

    assert_redirected_to controlqnynt_url(Controlqnynt.last)
  end

  test "should show controlqnynt" do
    get controlqnynt_url(@controlqnynt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlqnynt_url(@controlqnynt)
    assert_response :success
  end

  test "should update controlqnynt" do
    patch controlqnynt_url(@controlqnynt), params: { controlqnynt: { limite: @controlqnynt.limite, numero: @controlqnynt.numero, vendida: @controlqnynt.vendida } }
    assert_redirected_to controlqnynt_url(@controlqnynt)
  end

  test "should destroy controlqnynt" do
    assert_difference('Controlqnynt.count', -1) do
      delete controlqnynt_url(@controlqnynt)
    end

    assert_redirected_to controlqnynts_url
  end
end
