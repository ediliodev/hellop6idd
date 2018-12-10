require 'test_helper'

class ControlqnyttsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlqnytt = controlqnytts(:one)
  end

  test "should get index" do
    get controlqnytts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlqnytt_url
    assert_response :success
  end

  test "should create controlqnytt" do
    assert_difference('Controlqnytt.count') do
      post controlqnytts_url, params: { controlqnytt: { limite: @controlqnytt.limite, numero: @controlqnytt.numero, vendida: @controlqnytt.vendida } }
    end

    assert_redirected_to controlqnytt_url(Controlqnytt.last)
  end

  test "should show controlqnytt" do
    get controlqnytt_url(@controlqnytt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlqnytt_url(@controlqnytt)
    assert_response :success
  end

  test "should update controlqnytt" do
    patch controlqnytt_url(@controlqnytt), params: { controlqnytt: { limite: @controlqnytt.limite, numero: @controlqnytt.numero, vendida: @controlqnytt.vendida } }
    assert_redirected_to controlqnytt_url(@controlqnytt)
  end

  test "should destroy controlqnytt" do
    assert_difference('Controlqnytt.count', -1) do
      delete controlqnytt_url(@controlqnytt)
    end

    assert_redirected_to controlqnytts_url
  end
end
