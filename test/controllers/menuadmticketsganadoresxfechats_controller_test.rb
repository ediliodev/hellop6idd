require 'test_helper'

class MenuadmticketsganadoresxfechatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menuadmticketsganadoresxfechat = menuadmticketsganadoresxfechats(:one)
  end

  test "should get index" do
    get menuadmticketsganadoresxfechats_url
    assert_response :success
  end

  test "should get new" do
    get new_menuadmticketsganadoresxfechat_url
    assert_response :success
  end

  test "should create menuadmticketsganadoresxfechat" do
    assert_difference('Menuadmticketsganadoresxfechat.count') do
      post menuadmticketsganadoresxfechats_url, params: { menuadmticketsganadoresxfechat: { desde: @menuadmticketsganadoresxfechat.desde, hasta: @menuadmticketsganadoresxfechat.hasta, sucursal: @menuadmticketsganadoresxfechat.sucursal } }
    end

    assert_redirected_to menuadmticketsganadoresxfechat_url(Menuadmticketsganadoresxfechat.last)
  end

  test "should show menuadmticketsganadoresxfechat" do
    get menuadmticketsganadoresxfechat_url(@menuadmticketsganadoresxfechat)
    assert_response :success
  end

  test "should get edit" do
    get edit_menuadmticketsganadoresxfechat_url(@menuadmticketsganadoresxfechat)
    assert_response :success
  end

  test "should update menuadmticketsganadoresxfechat" do
    patch menuadmticketsganadoresxfechat_url(@menuadmticketsganadoresxfechat), params: { menuadmticketsganadoresxfechat: { desde: @menuadmticketsganadoresxfechat.desde, hasta: @menuadmticketsganadoresxfechat.hasta, sucursal: @menuadmticketsganadoresxfechat.sucursal } }
    assert_redirected_to menuadmticketsganadoresxfechat_url(@menuadmticketsganadoresxfechat)
  end

  test "should destroy menuadmticketsganadoresxfechat" do
    assert_difference('Menuadmticketsganadoresxfechat.count', -1) do
      delete menuadmticketsganadoresxfechat_url(@menuadmticketsganadoresxfechat)
    end

    assert_redirected_to menuadmticketsganadoresxfechats_url
  end
end
