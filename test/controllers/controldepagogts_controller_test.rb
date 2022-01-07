require 'test_helper'

class ControldepagogtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controldepagogt = controldepagogts(:one)
  end

  test "should get index" do
    get controldepagogts_url
    assert_response :success
  end

  test "should get new" do
    get new_controldepagogt_url
    assert_response :success
  end

  test "should create controldepagogt" do
    assert_difference('Controldepagogt.count') do
      post controldepagogts_url, params: { controldepagogt: { limiteglobal: @controldepagogt.limiteglobal, limitexticket: @controldepagogt.limitexticket, tipojugada: @controldepagogt.tipojugada } }
    end

    assert_redirected_to controldepagogt_url(Controldepagogt.last)
  end

  test "should show controldepagogt" do
    get controldepagogt_url(@controldepagogt)
    assert_response :success
  end

  test "should get edit" do
    get edit_controldepagogt_url(@controldepagogt)
    assert_response :success
  end

  test "should update controldepagogt" do
    patch controldepagogt_url(@controldepagogt), params: { controldepagogt: { limiteglobal: @controldepagogt.limiteglobal, limitexticket: @controldepagogt.limitexticket, tipojugada: @controldepagogt.tipojugada } }
    assert_redirected_to controldepagogt_url(@controldepagogt)
  end

  test "should destroy controldepagogt" do
    assert_difference('Controldepagogt.count', -1) do
      delete controldepagogt_url(@controldepagogt)
    end

    assert_redirected_to controldepagogts_url
  end
end
