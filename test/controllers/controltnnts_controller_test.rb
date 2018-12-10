require 'test_helper'

class ControltnntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controltnnt = controltnnts(:one)
  end

  test "should get index" do
    get controltnnts_url
    assert_response :success
  end

  test "should get new" do
    get new_controltnnt_url
    assert_response :success
  end

  test "should create controltnnt" do
    assert_difference('Controltnnt.count') do
      post controltnnts_url, params: { controltnnt: { limite: @controltnnt.limite, n1: @controltnnt.n1, n2: @controltnnt.n2, n3: @controltnnt.n3, siglas: @controltnnt.siglas, vendida: @controltnnt.vendida } }
    end

    assert_redirected_to controltnnt_url(Controltnnt.last)
  end

  test "should show controltnnt" do
    get controltnnt_url(@controltnnt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controltnnt_url(@controltnnt)
    assert_response :success
  end

  test "should update controltnnt" do
    patch controltnnt_url(@controltnnt), params: { controltnnt: { limite: @controltnnt.limite, n1: @controltnnt.n1, n2: @controltnnt.n2, n3: @controltnnt.n3, siglas: @controltnnt.siglas, vendida: @controltnnt.vendida } }
    assert_redirected_to controltnnt_url(@controltnnt)
  end

  test "should destroy controltnnt" do
    assert_difference('Controltnnt.count', -1) do
      delete controltnnt_url(@controltnnt)
    end

    assert_redirected_to controltnnts_url
  end
end
