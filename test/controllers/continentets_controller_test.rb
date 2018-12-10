require 'test_helper'

class ContinentetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @continentet = continentets(:one)
  end

  test "should get index" do
    get continentets_url
    assert_response :success
  end

  test "should get new" do
    get new_continentet_url
    assert_response :success
  end

  test "should create continentet" do
    assert_difference('Continentet.count') do
      post continentets_url, params: { continentet: { descripcion: @continentet.descripcion, nombre: @continentet.nombre } }
    end

    assert_redirected_to continentet_url(Continentet.last)
  end

  test "should show continentet" do
    get continentet_url(@continentet)
    assert_response :success
  end

  test "should get edit" do
    get edit_continentet_url(@continentet)
    assert_response :success
  end

  test "should update continentet" do
    patch continentet_url(@continentet), params: { continentet: { descripcion: @continentet.descripcion, nombre: @continentet.nombre } }
    assert_redirected_to continentet_url(@continentet)
  end

  test "should destroy continentet" do
    assert_difference('Continentet.count', -1) do
      delete continentet_url(@continentet)
    end

    assert_redirected_to continentets_url
  end
end
