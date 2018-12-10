require 'test_helper'

class HorariosorteotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @horariosorteot = horariosorteots(:one)
  end

  test "should get index" do
    get horariosorteots_url
    assert_response :success
  end

  test "should get new" do
    get new_horariosorteot_url
    assert_response :success
  end

  test "should create horariosorteot" do
    assert_difference('Horariosorteot.count') do
      post horariosorteots_url, params: { horariosorteot: { domingo: @horariosorteot.domingo, jueves: @horariosorteot.jueves, lunes: @horariosorteot.lunes, martes: @horariosorteot.martes, miercoles: @horariosorteot.miercoles, nombre: @horariosorteot.nombre, sabado: @horariosorteot.sabado, viernes: @horariosorteot.viernes } }
    end

    assert_redirected_to horariosorteot_url(Horariosorteot.last)
  end

  test "should show horariosorteot" do
    get horariosorteot_url(@horariosorteot)
    assert_response :success
  end

  test "should get edit" do
    get edit_horariosorteot_url(@horariosorteot)
    assert_response :success
  end

  test "should update horariosorteot" do
    patch horariosorteot_url(@horariosorteot), params: { horariosorteot: { domingo: @horariosorteot.domingo, jueves: @horariosorteot.jueves, lunes: @horariosorteot.lunes, martes: @horariosorteot.martes, miercoles: @horariosorteot.miercoles, nombre: @horariosorteot.nombre, sabado: @horariosorteot.sabado, viernes: @horariosorteot.viernes } }
    assert_redirected_to horariosorteot_url(@horariosorteot)
  end

  test "should destroy horariosorteot" do
    assert_difference('Horariosorteot.count', -1) do
      delete horariosorteot_url(@horariosorteot)
    end

    assert_redirected_to horariosorteots_url
  end
end
