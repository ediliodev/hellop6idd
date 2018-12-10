require 'test_helper'

class MonedatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monedat = monedats(:one)
  end

  test "should get index" do
    get monedats_url
    assert_response :success
  end

  test "should get new" do
    get new_monedat_url
    assert_response :success
  end

  test "should create monedat" do
    assert_difference('Monedat.count') do
      post monedats_url, params: { monedat: { descripcion: @monedat.descripcion, nombre: @monedat.nombre, paist_id: @monedat.paist_id, simbolo: @monedat.simbolo } }
    end

    assert_redirected_to monedat_url(Monedat.last)
  end

  test "should show monedat" do
    get monedat_url(@monedat)
    assert_response :success
  end

  test "should get edit" do
    get edit_monedat_url(@monedat)
    assert_response :success
  end

  test "should update monedat" do
    patch monedat_url(@monedat), params: { monedat: { descripcion: @monedat.descripcion, nombre: @monedat.nombre, paist_id: @monedat.paist_id, simbolo: @monedat.simbolo } }
    assert_redirected_to monedat_url(@monedat)
  end

  test "should destroy monedat" do
    assert_difference('Monedat.count', -1) do
      delete monedat_url(@monedat)
    end

    assert_redirected_to monedats_url
  end
end
