require 'test_helper'

class ControlqleitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlqleit = controlqleits(:one)
  end

  test "should get index" do
    get controlqleits_url
    assert_response :success
  end

  test "should get new" do
    get new_controlqleit_url
    assert_response :success
  end

  test "should create controlqleit" do
    assert_difference('Controlqleit.count') do
      post controlqleits_url, params: { controlqleit: { limite: @controlqleit.limite, numero: @controlqleit.numero, vendida: @controlqleit.vendida } }
    end

    assert_redirected_to controlqleit_url(Controlqleit.last)
  end

  test "should show controlqleit" do
    get controlqleit_url(@controlqleit)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlqleit_url(@controlqleit)
    assert_response :success
  end

  test "should update controlqleit" do
    patch controlqleit_url(@controlqleit), params: { controlqleit: { limite: @controlqleit.limite, numero: @controlqleit.numero, vendida: @controlqleit.vendida } }
    assert_redirected_to controlqleit_url(@controlqleit)
  end

  test "should destroy controlqleit" do
    assert_difference('Controlqleit.count', -1) do
      delete controlqleit_url(@controlqleit)
    end

    assert_redirected_to controlqleits_url
  end
end
