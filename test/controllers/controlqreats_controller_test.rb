require 'test_helper'

class ControlqreatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlqreat = controlqreats(:one)
  end

  test "should get index" do
    get controlqreats_url
    assert_response :success
  end

  test "should get new" do
    get new_controlqreat_url
    assert_response :success
  end

  test "should create controlqreat" do
    assert_difference('Controlqreat.count') do
      post controlqreats_url, params: { controlqreat: { limite: @controlqreat.limite, numero: @controlqreat.numero, vendida: @controlqreat.vendida } }
    end

    assert_redirected_to controlqreat_url(Controlqreat.last)
  end

  test "should show controlqreat" do
    get controlqreat_url(@controlqreat)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlqreat_url(@controlqreat)
    assert_response :success
  end

  test "should update controlqreat" do
    patch controlqreat_url(@controlqreat), params: { controlqreat: { limite: @controlqreat.limite, numero: @controlqreat.numero, vendida: @controlqreat.vendida } }
    assert_redirected_to controlqreat_url(@controlqreat)
  end

  test "should destroy controlqreat" do
    assert_difference('Controlqreat.count', -1) do
      delete controlqreat_url(@controlqreat)
    end

    assert_redirected_to controlqreats_url
  end
end
