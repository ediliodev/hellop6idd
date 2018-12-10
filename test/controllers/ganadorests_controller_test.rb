require 'test_helper'

class GanadorestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ganadorest = ganadorests(:one)
  end

  test "should get index" do
    get ganadorests_url
    assert_response :success
  end

  test "should get new" do
    get new_ganadorest_url
    assert_response :success
  end

  test "should create ganadorest" do
    assert_difference('Ganadorest.count') do
      post ganadorests_url, params: { ganadorest: { fecha: @ganadorest.fecha, primero: @ganadorest.primero, segundo: @ganadorest.segundo, sorteot_id: @ganadorest.sorteot_id, tercero: @ganadorest.tercero } }
    end

    assert_redirected_to ganadorest_url(Ganadorest.last)
  end

  test "should show ganadorest" do
    get ganadorest_url(@ganadorest)
    assert_response :success
  end

  test "should get edit" do
    get edit_ganadorest_url(@ganadorest)
    assert_response :success
  end

  test "should update ganadorest" do
    patch ganadorest_url(@ganadorest), params: { ganadorest: { fecha: @ganadorest.fecha, primero: @ganadorest.primero, segundo: @ganadorest.segundo, sorteot_id: @ganadorest.sorteot_id, tercero: @ganadorest.tercero } }
    assert_redirected_to ganadorest_url(@ganadorest)
  end

  test "should destroy ganadorest" do
    assert_difference('Ganadorest.count', -1) do
      delete ganadorest_url(@ganadorest)
    end

    assert_redirected_to ganadorests_url
  end
end
