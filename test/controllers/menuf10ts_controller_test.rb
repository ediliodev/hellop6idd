require 'test_helper'

class Menuf10tsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menuf10t = menuf10ts(:one)
  end

  test "should get index" do
    get menuf10ts_url
    assert_response :success
  end

  test "should get new" do
    get new_menuf10t_url
    assert_response :success
  end

  test "should create menuf10t" do
    assert_difference('Menuf10t.count') do
      post menuf10ts_url, params: { menuf10t: { fecha: @menuf10t.fecha, sorteot_id: @menuf10t.sorteot_id } }
    end

    assert_redirected_to menuf10t_url(Menuf10t.last)
  end

  test "should show menuf10t" do
    get menuf10t_url(@menuf10t)
    assert_response :success
  end

  test "should get edit" do
    get edit_menuf10t_url(@menuf10t)
    assert_response :success
  end

  test "should update menuf10t" do
    patch menuf10t_url(@menuf10t), params: { menuf10t: { fecha: @menuf10t.fecha, sorteot_id: @menuf10t.sorteot_id } }
    assert_redirected_to menuf10t_url(@menuf10t)
  end

  test "should destroy menuf10t" do
    assert_difference('Menuf10t.count', -1) do
      delete menuf10t_url(@menuf10t)
    end

    assert_redirected_to menuf10ts_url
  end
end
