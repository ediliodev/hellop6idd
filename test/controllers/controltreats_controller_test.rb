require 'test_helper'

class ControltreatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controltreat = controltreats(:one)
  end

  test "should get index" do
    get controltreats_url
    assert_response :success
  end

  test "should get new" do
    get new_controltreat_url
    assert_response :success
  end

  test "should create controltreat" do
    assert_difference('Controltreat.count') do
      post controltreats_url, params: { controltreat: { limite: @controltreat.limite, n1: @controltreat.n1, n2: @controltreat.n2, n3: @controltreat.n3, siglas: @controltreat.siglas, vendida: @controltreat.vendida } }
    end

    assert_redirected_to controltreat_url(Controltreat.last)
  end

  test "should show controltreat" do
    get controltreat_url(@controltreat)
    assert_response :success
  end

  test "should get edit" do
    get edit_controltreat_url(@controltreat)
    assert_response :success
  end

  test "should update controltreat" do
    patch controltreat_url(@controltreat), params: { controltreat: { limite: @controltreat.limite, n1: @controltreat.n1, n2: @controltreat.n2, n3: @controltreat.n3, siglas: @controltreat.siglas, vendida: @controltreat.vendida } }
    assert_redirected_to controltreat_url(@controltreat)
  end

  test "should destroy controltreat" do
    assert_difference('Controltreat.count', -1) do
      delete controltreat_url(@controltreat)
    end

    assert_redirected_to controltreats_url
  end
end
