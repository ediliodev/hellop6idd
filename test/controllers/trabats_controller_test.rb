require 'test_helper'

class TrabatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trabat = trabats(:one)
  end

  test "should get index" do
    get trabats_url
    assert_response :success
  end

  test "should get new" do
    get new_trabat_url
    assert_response :success
  end

  test "should create trabat" do
    assert_difference('Trabat.count') do
      post trabats_url, params: { trabat: { descripcion: @trabat.descripcion, nombre: @trabat.nombre } }
    end

    assert_redirected_to trabat_url(Trabat.last)
  end

  test "should show trabat" do
    get trabat_url(@trabat)
    assert_response :success
  end

  test "should get edit" do
    get edit_trabat_url(@trabat)
    assert_response :success
  end

  test "should update trabat" do
    patch trabat_url(@trabat), params: { trabat: { descripcion: @trabat.descripcion, nombre: @trabat.nombre } }
    assert_redirected_to trabat_url(@trabat)
  end

  test "should destroy trabat" do
    assert_difference('Trabat.count', -1) do
      delete trabat_url(@trabat)
    end

    assert_redirected_to trabats_url
  end
end
