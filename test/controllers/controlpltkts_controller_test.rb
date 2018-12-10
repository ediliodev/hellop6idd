require 'test_helper'

class ControlpltktsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlpltkt = controlpltkts(:one)
  end

  test "should get index" do
    get controlpltkts_url
    assert_response :success
  end

  test "should get new" do
    get new_controlpltkt_url
    assert_response :success
  end

  test "should create controlpltkt" do
    assert_difference('Controlpltkt.count') do
      post controlpltkts_url, params: { controlpltkt: { limite: @controlpltkt.limite, n1: @controlpltkt.n1, n2: @controlpltkt.n2, siglas: @controlpltkt.siglas, vendida: @controlpltkt.vendida } }
    end

    assert_redirected_to controlpltkt_url(Controlpltkt.last)
  end

  test "should show controlpltkt" do
    get controlpltkt_url(@controlpltkt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlpltkt_url(@controlpltkt)
    assert_response :success
  end

  test "should update controlpltkt" do
    patch controlpltkt_url(@controlpltkt), params: { controlpltkt: { limite: @controlpltkt.limite, n1: @controlpltkt.n1, n2: @controlpltkt.n2, siglas: @controlpltkt.siglas, vendida: @controlpltkt.vendida } }
    assert_redirected_to controlpltkt_url(@controlpltkt)
  end

  test "should destroy controlpltkt" do
    assert_difference('Controlpltkt.count', -1) do
      delete controlpltkt_url(@controlpltkt)
    end

    assert_redirected_to controlpltkts_url
  end
end
