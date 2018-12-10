require 'test_helper'

class CiudadtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ciudadt = ciudadts(:one)
  end

  test "should get index" do
    get ciudadts_url
    assert_response :success
  end

  test "should get new" do
    get new_ciudadt_url
    assert_response :success
  end

  test "should create ciudadt" do
    assert_difference('Ciudadt.count') do
      post ciudadts_url, params: { ciudadt: { nombre: @ciudadt.nombre, provinciat_id: @ciudadt.provinciat_id } }
    end

    assert_redirected_to ciudadt_url(Ciudadt.last)
  end

  test "should show ciudadt" do
    get ciudadt_url(@ciudadt)
    assert_response :success
  end

  test "should get edit" do
    get edit_ciudadt_url(@ciudadt)
    assert_response :success
  end

  test "should update ciudadt" do
    patch ciudadt_url(@ciudadt), params: { ciudadt: { nombre: @ciudadt.nombre, provinciat_id: @ciudadt.provinciat_id } }
    assert_redirected_to ciudadt_url(@ciudadt)
  end

  test "should destroy ciudadt" do
    assert_difference('Ciudadt.count', -1) do
      delete ciudadt_url(@ciudadt)
    end

    assert_redirected_to ciudadts_url
  end
end
