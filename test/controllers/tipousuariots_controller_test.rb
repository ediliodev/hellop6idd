require 'test_helper'

class TipousuariotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tipousuariot = tipousuariots(:one)
  end

  test "should get index" do
    get tipousuariots_url
    assert_response :success
  end

  test "should get new" do
    get new_tipousuariot_url
    assert_response :success
  end

  test "should create tipousuariot" do
    assert_difference('Tipousuariot.count') do
      post tipousuariots_url, params: { tipousuariot: { descripcion: @tipousuariot.descripcion, tipo_usuario: @tipousuariot.tipo_usuario } }
    end

    assert_redirected_to tipousuariot_url(Tipousuariot.last)
  end

  test "should show tipousuariot" do
    get tipousuariot_url(@tipousuariot)
    assert_response :success
  end

  test "should get edit" do
    get edit_tipousuariot_url(@tipousuariot)
    assert_response :success
  end

  test "should update tipousuariot" do
    patch tipousuariot_url(@tipousuariot), params: { tipousuariot: { descripcion: @tipousuariot.descripcion, tipo_usuario: @tipousuariot.tipo_usuario } }
    assert_redirected_to tipousuariot_url(@tipousuariot)
  end

  test "should destroy tipousuariot" do
    assert_difference('Tipousuariot.count', -1) do
      delete tipousuariot_url(@tipousuariot)
    end

    assert_redirected_to tipousuariots_url
  end
end
