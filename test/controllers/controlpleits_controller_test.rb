require 'test_helper'

class ControlpleitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlpleit = controlpleits(:one)
  end

  test "should get index" do
    get controlpleits_url
    assert_response :success
  end

  test "should get new" do
    get new_controlpleit_url
    assert_response :success
  end

  test "should create controlpleit" do
    assert_difference('Controlpleit.count') do
      post controlpleits_url, params: { controlpleit: { limite: @controlpleit.limite, n1: @controlpleit.n1, n2: @controlpleit.n2, siglas: @controlpleit.siglas, vendida: @controlpleit.vendida } }
    end

    assert_redirected_to controlpleit_url(Controlpleit.last)
  end

  test "should show controlpleit" do
    get controlpleit_url(@controlpleit)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlpleit_url(@controlpleit)
    assert_response :success
  end

  test "should update controlpleit" do
    patch controlpleit_url(@controlpleit), params: { controlpleit: { limite: @controlpleit.limite, n1: @controlpleit.n1, n2: @controlpleit.n2, siglas: @controlpleit.siglas, vendida: @controlpleit.vendida } }
    assert_redirected_to controlpleit_url(@controlpleit)
  end

  test "should destroy controlpleit" do
    assert_difference('Controlpleit.count', -1) do
      delete controlpleit_url(@controlpleit)
    end

    assert_redirected_to controlpleits_url
  end
end
