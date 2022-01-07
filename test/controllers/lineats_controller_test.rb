require 'test_helper'

class LineatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lineat = lineats(:one)
  end

  test "should get index" do
    get lineats_url
    assert_response :success
  end

  test "should get new" do
    get new_lineat_url
    assert_response :success
  end

  test "should create lineat" do
    assert_difference('Lineat.count') do
      post lineats_url, params: { lineat: { azul: @lineat.azul, blanco: @lineat.blanco, bloque: @lineat.bloque, coliseo: @lineat.coliseo, mla: @lineat.mla, mlb: @lineat.mlb, oua: @lineat.oua, oub: @lineat.oub, pelea: @lineat.pelea, resultado: @lineat.resultado, status: @lineat.status, tiempofinalizado: @lineat.tiempofinalizado, tiempoml: @lineat.tiempoml } }
    end

    assert_redirected_to lineat_url(Lineat.last)
  end

  test "should show lineat" do
    get lineat_url(@lineat)
    assert_response :success
  end

  test "should get edit" do
    get edit_lineat_url(@lineat)
    assert_response :success
  end

  test "should update lineat" do
    patch lineat_url(@lineat), params: { lineat: { azul: @lineat.azul, blanco: @lineat.blanco, bloque: @lineat.bloque, coliseo: @lineat.coliseo, mla: @lineat.mla, mlb: @lineat.mlb, oua: @lineat.oua, oub: @lineat.oub, pelea: @lineat.pelea, resultado: @lineat.resultado, status: @lineat.status, tiempofinalizado: @lineat.tiempofinalizado, tiempoml: @lineat.tiempoml } }
    assert_redirected_to lineat_url(@lineat)
  end

  test "should destroy lineat" do
    assert_difference('Lineat.count', -1) do
      delete lineat_url(@lineat)
    end

    assert_redirected_to lineats_url
  end
end
