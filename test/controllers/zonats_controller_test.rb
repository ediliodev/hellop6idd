require 'test_helper'

class ZonatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @zonat = zonats(:one)
  end

  test "should get index" do
    get zonats_url
    assert_response :success
  end

  test "should get new" do
    get new_zonat_url
    assert_response :success
  end

  test "should create zonat" do
    assert_difference('Zonat.count') do
      post zonats_url, params: { zonat: { descripcion: @zonat.descripcion, nombre: @zonat.nombre } }
    end

    assert_redirected_to zonat_url(Zonat.last)
  end

  test "should show zonat" do
    get zonat_url(@zonat)
    assert_response :success
  end

  test "should get edit" do
    get edit_zonat_url(@zonat)
    assert_response :success
  end

  test "should update zonat" do
    patch zonat_url(@zonat), params: { zonat: { descripcion: @zonat.descripcion, nombre: @zonat.nombre } }
    assert_redirected_to zonat_url(@zonat)
  end

  test "should destroy zonat" do
    assert_difference('Zonat.count', -1) do
      delete zonat_url(@zonat)
    end

    assert_redirected_to zonats_url
  end
end
