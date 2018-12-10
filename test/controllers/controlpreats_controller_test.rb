require 'test_helper'

class ControlpreatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlpreat = controlpreats(:one)
  end

  test "should get index" do
    get controlpreats_url
    assert_response :success
  end

  test "should get new" do
    get new_controlpreat_url
    assert_response :success
  end

  test "should create controlpreat" do
    assert_difference('Controlpreat.count') do
      post controlpreats_url, params: { controlpreat: { limite: @controlpreat.limite, n1: @controlpreat.n1, n2: @controlpreat.n2, siglas: @controlpreat.siglas, vendida: @controlpreat.vendida } }
    end

    assert_redirected_to controlpreat_url(Controlpreat.last)
  end

  test "should show controlpreat" do
    get controlpreat_url(@controlpreat)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlpreat_url(@controlpreat)
    assert_response :success
  end

  test "should update controlpreat" do
    patch controlpreat_url(@controlpreat), params: { controlpreat: { limite: @controlpreat.limite, n1: @controlpreat.n1, n2: @controlpreat.n2, siglas: @controlpreat.siglas, vendida: @controlpreat.vendida } }
    assert_redirected_to controlpreat_url(@controlpreat)
  end

  test "should destroy controlpreat" do
    assert_difference('Controlpreat.count', -1) do
      delete controlpreat_url(@controlpreat)
    end

    assert_redirected_to controlpreats_url
  end
end
