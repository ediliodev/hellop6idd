require 'test_helper'

class MensajepiedepaginatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mensajepiedepaginat = mensajepiedepaginats(:one)
  end

  test "should get index" do
    get mensajepiedepaginats_url
    assert_response :success
  end

  test "should get new" do
    get new_mensajepiedepaginat_url
    assert_response :success
  end

  test "should create mensajepiedepaginat" do
    assert_difference('Mensajepiedepaginat.count') do
      post mensajepiedepaginats_url, params: { mensajepiedepaginat: { mensaje: @mensajepiedepaginat.mensaje, tipodemensaje: @mensajepiedepaginat.tipodemensaje } }
    end

    assert_redirected_to mensajepiedepaginat_url(Mensajepiedepaginat.last)
  end

  test "should show mensajepiedepaginat" do
    get mensajepiedepaginat_url(@mensajepiedepaginat)
    assert_response :success
  end

  test "should get edit" do
    get edit_mensajepiedepaginat_url(@mensajepiedepaginat)
    assert_response :success
  end

  test "should update mensajepiedepaginat" do
    patch mensajepiedepaginat_url(@mensajepiedepaginat), params: { mensajepiedepaginat: { mensaje: @mensajepiedepaginat.mensaje, tipodemensaje: @mensajepiedepaginat.tipodemensaje } }
    assert_redirected_to mensajepiedepaginat_url(@mensajepiedepaginat)
  end

  test "should destroy mensajepiedepaginat" do
    assert_difference('Mensajepiedepaginat.count', -1) do
      delete mensajepiedepaginat_url(@mensajepiedepaginat)
    end

    assert_redirected_to mensajepiedepaginats_url
  end
end
