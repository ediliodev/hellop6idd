require 'test_helper'

class ConsorciotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @consorciot = consorciots(:one)
  end

  test "should get index" do
    get consorciots_url
    assert_response :success
  end

  test "should get new" do
    get new_consorciot_url
    assert_response :success
  end

  test "should create consorciot" do
    assert_difference('Consorciot.count') do
      post consorciots_url, params: { consorciot: { abreviatura: @consorciot.abreviatura, nombre: @consorciot.nombre, telefono: @consorciot.telefono } }
    end

    assert_redirected_to consorciot_url(Consorciot.last)
  end

  test "should show consorciot" do
    get consorciot_url(@consorciot)
    assert_response :success
  end

  test "should get edit" do
    get edit_consorciot_url(@consorciot)
    assert_response :success
  end

  test "should update consorciot" do
    patch consorciot_url(@consorciot), params: { consorciot: { abreviatura: @consorciot.abreviatura, nombre: @consorciot.nombre, telefono: @consorciot.telefono } }
    assert_redirected_to consorciot_url(@consorciot)
  end

  test "should destroy consorciot" do
    assert_difference('Consorciot.count', -1) do
      delete consorciot_url(@consorciot)
    end

    assert_redirected_to consorciots_url
  end
end
