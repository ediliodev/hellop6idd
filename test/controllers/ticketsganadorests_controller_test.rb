require 'test_helper'

class TicketsganadorestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticketsganadorest = ticketsganadorests(:one)
  end

  test "should get index" do
    get ticketsganadorests_url
    assert_response :success
  end

  test "should get new" do
    get new_ticketsganadorest_url
    assert_response :success
  end

  test "should create ticketsganadorest" do
    assert_difference('Ticketsganadorest.count') do
      post ticketsganadorests_url, params: { ticketsganadorest: { jugada: @ticketsganadorest.jugada, montoacobrar: @ticketsganadorest.montoacobrar, montoapostado: @ticketsganadorest.montoapostado, ticket_id: @ticketsganadorest.ticket_id } }
    end

    assert_redirected_to ticketsganadorest_url(Ticketsganadorest.last)
  end

  test "should show ticketsganadorest" do
    get ticketsganadorest_url(@ticketsganadorest)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticketsganadorest_url(@ticketsganadorest)
    assert_response :success
  end

  test "should update ticketsganadorest" do
    patch ticketsganadorest_url(@ticketsganadorest), params: { ticketsganadorest: { jugada: @ticketsganadorest.jugada, montoacobrar: @ticketsganadorest.montoacobrar, montoapostado: @ticketsganadorest.montoapostado, ticket_id: @ticketsganadorest.ticket_id } }
    assert_redirected_to ticketsganadorest_url(@ticketsganadorest)
  end

  test "should destroy ticketsganadorest" do
    assert_difference('Ticketsganadorest.count', -1) do
      delete ticketsganadorest_url(@ticketsganadorest)
    end

    assert_redirected_to ticketsganadorests_url
  end
end
