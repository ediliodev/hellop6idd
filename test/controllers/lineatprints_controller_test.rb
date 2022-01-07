require 'test_helper'

class LineatprintsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lineatprint = lineatprints(:one)
  end

  test "should get index" do
    get lineatprints_url
    assert_response :success
  end

  test "should get new" do
    get new_lineatprint_url
    assert_response :success
  end

  test "should create lineatprint" do
    assert_difference('Lineatprint.count') do
      post lineatprints_url, params: { lineatprint: { azul: @lineatprint.azul, blanco: @lineatprint.blanco, bloque: @lineatprint.bloque, coliseo: @lineatprint.coliseo, ganador: @lineatprint.ganador, mla: @lineatprint.mla, mlb: @lineatprint.mlb, over: @lineatprint.over, pelea: @lineatprint.pelea, status: @lineatprint.status, tfinal: @lineatprint.tfinal, time: @lineatprint.time, under: @lineatprint.under } }
    end

    assert_redirected_to lineatprint_url(Lineatprint.last)
  end

  test "should show lineatprint" do
    get lineatprint_url(@lineatprint)
    assert_response :success
  end

  test "should get edit" do
    get edit_lineatprint_url(@lineatprint)
    assert_response :success
  end

  test "should update lineatprint" do
    patch lineatprint_url(@lineatprint), params: { lineatprint: { azul: @lineatprint.azul, blanco: @lineatprint.blanco, bloque: @lineatprint.bloque, coliseo: @lineatprint.coliseo, ganador: @lineatprint.ganador, mla: @lineatprint.mla, mlb: @lineatprint.mlb, over: @lineatprint.over, pelea: @lineatprint.pelea, status: @lineatprint.status, tfinal: @lineatprint.tfinal, time: @lineatprint.time, under: @lineatprint.under } }
    assert_redirected_to lineatprint_url(@lineatprint)
  end

  test "should destroy lineatprint" do
    assert_difference('Lineatprint.count', -1) do
      delete lineatprint_url(@lineatprint)
    end

    assert_redirected_to lineatprints_url
  end
end
