require 'test_helper'

class EmpleadotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @empleadot = empleadots(:one)
  end

  test "should get index" do
    get empleadots_url
    assert_response :success
  end

  test "should get new" do
    get new_empleadot_url
    assert_response :success
  end

  test "should create empleadot" do
    assert_difference('Empleadot.count') do
      post empleadots_url, params: { empleadot: { apellido: @empleadot.apellido, cedula: @empleadot.cedula, nombre: @empleadot.nombre, telefono: @empleadot.telefono } }
    end

    assert_redirected_to empleadot_url(Empleadot.last)
  end

  test "should show empleadot" do
    get empleadot_url(@empleadot)
    assert_response :success
  end

  test "should get edit" do
    get edit_empleadot_url(@empleadot)
    assert_response :success
  end

  test "should update empleadot" do
    patch empleadot_url(@empleadot), params: { empleadot: { apellido: @empleadot.apellido, cedula: @empleadot.cedula, nombre: @empleadot.nombre, telefono: @empleadot.telefono } }
    assert_redirected_to empleadot_url(@empleadot)
  end

  test "should destroy empleadot" do
    assert_difference('Empleadot.count', -1) do
      delete empleadot_url(@empleadot)
    end

    assert_redirected_to empleadots_url
  end
end
