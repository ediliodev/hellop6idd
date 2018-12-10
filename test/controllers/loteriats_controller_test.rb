require 'test_helper'

class LoteriatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loteriat = loteriats(:one)
  end

  test "should get index" do
    get loteriats_url
    assert_response :success
  end

  test "should get new" do
    get new_loteriat_url
    assert_response :success
  end

  test "should create loteriat" do
    assert_difference('Loteriat.count') do
      post loteriats_url, params: { loteriat: { descripcion: @loteriat.descripcion, nombre: @loteriat.nombre, paist_id: @loteriat.paist_id } }
    end

    assert_redirected_to loteriat_url(Loteriat.last)
  end

  test "should show loteriat" do
    get loteriat_url(@loteriat)
    assert_response :success
  end

  test "should get edit" do
    get edit_loteriat_url(@loteriat)
    assert_response :success
  end

  test "should update loteriat" do
    patch loteriat_url(@loteriat), params: { loteriat: { descripcion: @loteriat.descripcion, nombre: @loteriat.nombre, paist_id: @loteriat.paist_id } }
    assert_redirected_to loteriat_url(@loteriat)
  end

  test "should destroy loteriat" do
    assert_difference('Loteriat.count', -1) do
      delete loteriat_url(@loteriat)
    end

    assert_redirected_to loteriats_url
  end
end
