require 'test_helper'

class MenuposrventaxfechatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menuposrventaxfechat = menuposrventaxfechats(:one)
  end

  test "should get index" do
    get menuposrventaxfechats_url
    assert_response :success
  end

  test "should get new" do
    get new_menuposrventaxfechat_url
    assert_response :success
  end

  test "should create menuposrventaxfechat" do
    assert_difference('Menuposrventaxfechat.count') do
      post menuposrventaxfechats_url, params: { menuposrventaxfechat: { desde: @menuposrventaxfechat.desde, hasta: @menuposrventaxfechat.hasta, sucursal: @menuposrventaxfechat.sucursal, venta: @menuposrventaxfechat.venta } }
    end

    assert_redirected_to menuposrventaxfechat_url(Menuposrventaxfechat.last)
  end

  test "should show menuposrventaxfechat" do
    get menuposrventaxfechat_url(@menuposrventaxfechat)
    assert_response :success
  end

  test "should get edit" do
    get edit_menuposrventaxfechat_url(@menuposrventaxfechat)
    assert_response :success
  end

  test "should update menuposrventaxfechat" do
    patch menuposrventaxfechat_url(@menuposrventaxfechat), params: { menuposrventaxfechat: { desde: @menuposrventaxfechat.desde, hasta: @menuposrventaxfechat.hasta, sucursal: @menuposrventaxfechat.sucursal, venta: @menuposrventaxfechat.venta } }
    assert_redirected_to menuposrventaxfechat_url(@menuposrventaxfechat)
  end

  test "should destroy menuposrventaxfechat" do
    assert_difference('Menuposrventaxfechat.count', -1) do
      delete menuposrventaxfechat_url(@menuposrventaxfechat)
    end

    assert_redirected_to menuposrventaxfechats_url
  end
end
