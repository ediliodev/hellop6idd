require 'test_helper'

class JugadalotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @jugadalot = jugadalots(:one)
  end

  test "should get index" do
    get jugadalots_url
    assert_response :success
  end

  test "should get new" do
    get new_jugadalot_url
    assert_response :success
  end

  test "should create jugadalot" do
    assert_difference('Jugadalot.count') do
      post jugadalots_url, params: { jugadalot: { monto: @jugadalot.monto, n1: @jugadalot.n1, n2: @jugadalot.n2, n3: @jugadalot.n3, qpt: @jugadalot.qpt, sorteo: @jugadalot.sorteo, ticket: @jugadalot.ticket } }
    end

    assert_redirected_to jugadalot_url(Jugadalot.last)
  end

  test "should show jugadalot" do
    get jugadalot_url(@jugadalot)
    assert_response :success
  end

  test "should get edit" do
    get edit_jugadalot_url(@jugadalot)
    assert_response :success
  end

  test "should update jugadalot" do
    patch jugadalot_url(@jugadalot), params: { jugadalot: { monto: @jugadalot.monto, n1: @jugadalot.n1, n2: @jugadalot.n2, n3: @jugadalot.n3, qpt: @jugadalot.qpt, sorteo: @jugadalot.sorteo, ticket: @jugadalot.ticket } }
    assert_redirected_to jugadalot_url(@jugadalot)
  end

  test "should destroy jugadalot" do
    assert_difference('Jugadalot.count', -1) do
      delete jugadalot_url(@jugadalot)
    end

    assert_redirected_to jugadalots_url
  end
end
