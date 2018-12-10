require 'test_helper'

class SociotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sociot = sociots(:one)
  end

  test "should get index" do
    get sociots_url
    assert_response :success
  end

  test "should get new" do
    get new_sociot_url
    assert_response :success
  end

  test "should create sociot" do
    assert_difference('Sociot.count') do
      post sociots_url, params: { sociot: { apellido: @sociot.apellido, nombre: @sociot.nombre, telefono: @sociot.telefono } }
    end

    assert_redirected_to sociot_url(Sociot.last)
  end

  test "should show sociot" do
    get sociot_url(@sociot)
    assert_response :success
  end

  test "should get edit" do
    get edit_sociot_url(@sociot)
    assert_response :success
  end

  test "should update sociot" do
    patch sociot_url(@sociot), params: { sociot: { apellido: @sociot.apellido, nombre: @sociot.nombre, telefono: @sociot.telefono } }
    assert_redirected_to sociot_url(@sociot)
  end

  test "should destroy sociot" do
    assert_difference('Sociot.count', -1) do
      delete sociot_url(@sociot)
    end

    assert_redirected_to sociots_url
  end
end
