require 'test_helper'

class PaistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paist = paists(:one)
  end

  test "should get index" do
    get paists_url
    assert_response :success
  end

  test "should get new" do
    get new_paist_url
    assert_response :success
  end

  test "should create paist" do
    assert_difference('Paist.count') do
      post paists_url, params: { paist: { continentet_id: @paist.continentet_id, nombre: @paist.nombre } }
    end

    assert_redirected_to paist_url(Paist.last)
  end

  test "should show paist" do
    get paist_url(@paist)
    assert_response :success
  end

  test "should get edit" do
    get edit_paist_url(@paist)
    assert_response :success
  end

  test "should update paist" do
    patch paist_url(@paist), params: { paist: { continentet_id: @paist.continentet_id, nombre: @paist.nombre } }
    assert_redirected_to paist_url(@paist)
  end

  test "should destroy paist" do
    assert_difference('Paist.count', -1) do
      delete paist_url(@paist)
    end

    assert_redirected_to paists_url
  end
end
