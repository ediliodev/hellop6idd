require 'test_helper'

class ProvinciatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @provinciat = provinciats(:one)
  end

  test "should get index" do
    get provinciats_url
    assert_response :success
  end

  test "should get new" do
    get new_provinciat_url
    assert_response :success
  end

  test "should create provinciat" do
    assert_difference('Provinciat.count') do
      post provinciats_url, params: { provinciat: { nombre: @provinciat.nombre, paist_id: @provinciat.paist_id } }
    end

    assert_redirected_to provinciat_url(Provinciat.last)
  end

  test "should show provinciat" do
    get provinciat_url(@provinciat)
    assert_response :success
  end

  test "should get edit" do
    get edit_provinciat_url(@provinciat)
    assert_response :success
  end

  test "should update provinciat" do
    patch provinciat_url(@provinciat), params: { provinciat: { nombre: @provinciat.nombre, paist_id: @provinciat.paist_id } }
    assert_redirected_to provinciat_url(@provinciat)
  end

  test "should destroy provinciat" do
    assert_difference('Provinciat.count', -1) do
      delete provinciat_url(@provinciat)
    end

    assert_redirected_to provinciats_url
  end
end
