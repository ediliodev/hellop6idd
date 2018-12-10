require 'test_helper'

class SupervisortsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supervisort = supervisorts(:one)
  end

  test "should get index" do
    get supervisorts_url
    assert_response :success
  end

  test "should get new" do
    get new_supervisort_url
    assert_response :success
  end

  test "should create supervisort" do
    assert_difference('Supervisort.count') do
      post supervisorts_url, params: { supervisort: { apellido: @supervisort.apellido, cedula: @supervisort.cedula, nombre: @supervisort.nombre, telefono: @supervisort.telefono } }
    end

    assert_redirected_to supervisort_url(Supervisort.last)
  end

  test "should show supervisort" do
    get supervisort_url(@supervisort)
    assert_response :success
  end

  test "should get edit" do
    get edit_supervisort_url(@supervisort)
    assert_response :success
  end

  test "should update supervisort" do
    patch supervisort_url(@supervisort), params: { supervisort: { apellido: @supervisort.apellido, cedula: @supervisort.cedula, nombre: @supervisort.nombre, telefono: @supervisort.telefono } }
    assert_redirected_to supervisort_url(@supervisort)
  end

  test "should destroy supervisort" do
    assert_difference('Supervisort.count', -1) do
      delete supervisort_url(@supervisort)
    end

    assert_redirected_to supervisorts_url
  end
end
