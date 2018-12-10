require 'test_helper'

class MenuadmrresultadoglobaltsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menuadmrresultadoglobalt = menuadmrresultadoglobalts(:one)
  end

  test "should get index" do
    get menuadmrresultadoglobalts_url
    assert_response :success
  end

  test "should get new" do
    get new_menuadmrresultadoglobalt_url
    assert_response :success
  end

  test "should create menuadmrresultadoglobalt" do
    assert_difference('Menuadmrresultadoglobalt.count') do
      post menuadmrresultadoglobalts_url, params: { menuadmrresultadoglobalt: { balance: @menuadmrresultadoglobalt.balance, desde: @menuadmrresultadoglobalt.desde, ganadores: @menuadmrresultadoglobalt.ganadores, hasta: @menuadmrresultadoglobalt.hasta, sucursal: @menuadmrresultadoglobalt.sucursal, venta: @menuadmrresultadoglobalt.venta } }
    end

    assert_redirected_to menuadmrresultadoglobalt_url(Menuadmrresultadoglobalt.last)
  end

  test "should show menuadmrresultadoglobalt" do
    get menuadmrresultadoglobalt_url(@menuadmrresultadoglobalt)
    assert_response :success
  end

  test "should get edit" do
    get edit_menuadmrresultadoglobalt_url(@menuadmrresultadoglobalt)
    assert_response :success
  end

  test "should update menuadmrresultadoglobalt" do
    patch menuadmrresultadoglobalt_url(@menuadmrresultadoglobalt), params: { menuadmrresultadoglobalt: { balance: @menuadmrresultadoglobalt.balance, desde: @menuadmrresultadoglobalt.desde, ganadores: @menuadmrresultadoglobalt.ganadores, hasta: @menuadmrresultadoglobalt.hasta, sucursal: @menuadmrresultadoglobalt.sucursal, venta: @menuadmrresultadoglobalt.venta } }
    assert_redirected_to menuadmrresultadoglobalt_url(@menuadmrresultadoglobalt)
  end

  test "should destroy menuadmrresultadoglobalt" do
    assert_difference('Menuadmrresultadoglobalt.count', -1) do
      delete menuadmrresultadoglobalt_url(@menuadmrresultadoglobalt)
    end

    assert_redirected_to menuadmrresultadoglobalts_url
  end
end
