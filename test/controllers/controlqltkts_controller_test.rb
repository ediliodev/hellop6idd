require 'test_helper'

class ControlqltktsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlqltkt = controlqltkts(:one)
  end

  test "should get index" do
    get controlqltkts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlqltkt_url
    assert_response :success
  end

  test "should create controlqltkt" do
    assert_difference('Controlqltkt.count') do
      post controlqltkts_url, params: { controlqltkt: { limite: @controlqltkt.limite, numero: @controlqltkt.numero, vendida: @controlqltkt.vendida } }
    end

    assert_redirected_to controlqltkt_url(Controlqltkt.last)
  end

  test "should show controlqltkt" do
    get controlqltkt_url(@controlqltkt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlqltkt_url(@controlqltkt)
    assert_response :success
  end

  test "should update controlqltkt" do
    patch controlqltkt_url(@controlqltkt), params: { controlqltkt: { limite: @controlqltkt.limite, numero: @controlqltkt.numero, vendida: @controlqltkt.vendida } }
    assert_redirected_to controlqltkt_url(@controlqltkt)
  end

  test "should destroy controlqltkt" do
    assert_difference('Controlqltkt.count', -1) do
      delete controlqltkt_url(@controlqltkt)
    end

    assert_redirected_to controlqltkts_url
  end
end
