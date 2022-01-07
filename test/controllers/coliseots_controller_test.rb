require 'test_helper'

class ColiseotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coliseot = coliseots(:one)
  end

  test "should get index" do
    get coliseots_url
    assert_response :success
  end

  test "should get new" do
    get new_coliseot_url
    assert_response :success
  end

  test "should create coliseot" do
    assert_difference('Coliseot.count') do
      post coliseots_url, params: { coliseot: { descripcion: @coliseot.descripcion, nombre: @coliseot.nombre } }
    end

    assert_redirected_to coliseot_url(Coliseot.last)
  end

  test "should show coliseot" do
    get coliseot_url(@coliseot)
    assert_response :success
  end

  test "should get edit" do
    get edit_coliseot_url(@coliseot)
    assert_response :success
  end

  test "should update coliseot" do
    patch coliseot_url(@coliseot), params: { coliseot: { descripcion: @coliseot.descripcion, nombre: @coliseot.nombre } }
    assert_redirected_to coliseot_url(@coliseot)
  end

  test "should destroy coliseot" do
    assert_difference('Coliseot.count', -1) do
      delete coliseot_url(@coliseot)
    end

    assert_redirected_to coliseots_url
  end
end
