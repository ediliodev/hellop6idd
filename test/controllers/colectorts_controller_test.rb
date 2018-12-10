require 'test_helper'

class ColectortsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @colectort = colectorts(:one)
  end

  test "should get index" do
    get colectorts_url
    assert_response :success
  end

  test "should get new" do
    get new_colectort_url
    assert_response :success
  end

  test "should create colectort" do
    assert_difference('Colectort.count') do
      post colectorts_url, params: { colectort: { apellido: @colectort.apellido, cedula: @colectort.cedula, nombre: @colectort.nombre, telefono: @colectort.telefono } }
    end

    assert_redirected_to colectort_url(Colectort.last)
  end

  test "should show colectort" do
    get colectort_url(@colectort)
    assert_response :success
  end

  test "should get edit" do
    get edit_colectort_url(@colectort)
    assert_response :success
  end

  test "should update colectort" do
    patch colectort_url(@colectort), params: { colectort: { apellido: @colectort.apellido, cedula: @colectort.cedula, nombre: @colectort.nombre, telefono: @colectort.telefono } }
    assert_redirected_to colectort_url(@colectort)
  end

  test "should destroy colectort" do
    assert_difference('Colectort.count', -1) do
      delete colectort_url(@colectort)
    end

    assert_redirected_to colectorts_url
  end
end
