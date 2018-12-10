require 'test_helper'

class MenuposrventadiaactualtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menuposrventadiaactualt = menuposrventadiaactualts(:one)
  end

  test "should get index" do
    get menuposrventadiaactualts_url
    assert_response :success
  end

  test "should get new" do
    get new_menuposrventadiaactualt_url
    assert_response :success
  end

  test "should create menuposrventadiaactualt" do
    assert_difference('Menuposrventadiaactualt.count') do
      post menuposrventadiaactualts_url, params: { menuposrventadiaactualt: { fecha: @menuposrventadiaactualt.fecha, sucursal: @menuposrventadiaactualt.sucursal, venta: @menuposrventadiaactualt.venta } }
    end

    assert_redirected_to menuposrventadiaactualt_url(Menuposrventadiaactualt.last)
  end

  test "should show menuposrventadiaactualt" do
    get menuposrventadiaactualt_url(@menuposrventadiaactualt)
    assert_response :success
  end

  test "should get edit" do
    get edit_menuposrventadiaactualt_url(@menuposrventadiaactualt)
    assert_response :success
  end

  test "should update menuposrventadiaactualt" do
    patch menuposrventadiaactualt_url(@menuposrventadiaactualt), params: { menuposrventadiaactualt: { fecha: @menuposrventadiaactualt.fecha, sucursal: @menuposrventadiaactualt.sucursal, venta: @menuposrventadiaactualt.venta } }
    assert_redirected_to menuposrventadiaactualt_url(@menuposrventadiaactualt)
  end

  test "should destroy menuposrventadiaactualt" do
    assert_difference('Menuposrventadiaactualt.count', -1) do
      delete menuposrventadiaactualt_url(@menuposrventadiaactualt)
    end

    assert_redirected_to menuposrventadiaactualts_url
  end
end
