require 'test_helper'

class SorteotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sorteot = sorteots(:one)
  end

  test "should get index" do
    get sorteots_url
    assert_response :success
  end

  test "should get new" do
    get new_sorteot_url
    assert_response :success
  end

  test "should create sorteot" do
    assert_difference('Sorteot.count') do
      post sorteots_url, params: { sorteot: { abierto: @sorteot.abierto, activo: @sorteot.activo, descripcion: @sorteot.descripcion, horariosorteot_id: @sorteot.horariosorteot_id, loteriat_id: @sorteot.loteriat_id, nombre: @sorteot.nombre, sigla: @sorteot.sigla } }
    end

    assert_redirected_to sorteot_url(Sorteot.last)
  end

  test "should show sorteot" do
    get sorteot_url(@sorteot)
    assert_response :success
  end

  test "should get edit" do
    get edit_sorteot_url(@sorteot)
    assert_response :success
  end

  test "should update sorteot" do
    patch sorteot_url(@sorteot), params: { sorteot: { abierto: @sorteot.abierto, activo: @sorteot.activo, descripcion: @sorteot.descripcion, horariosorteot_id: @sorteot.horariosorteot_id, loteriat_id: @sorteot.loteriat_id, nombre: @sorteot.nombre, sigla: @sorteot.sigla } }
    assert_redirected_to sorteot_url(@sorteot)
  end

  test "should destroy sorteot" do
    assert_difference('Sorteot.count', -1) do
      delete sorteot_url(@sorteot)
    end

    assert_redirected_to sorteots_url
  end
end
