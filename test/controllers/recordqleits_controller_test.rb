require 'test_helper'

class RecordqleitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordqleit = recordqleits(:one)
  end

  test "should get index" do
    get recordqleits_url
    assert_response :success
  end

  test "should get new" do
    get new_recordqleit_url
    assert_response :success
  end

  test "should create recordqleit" do
    assert_difference('Recordqleit.count') do
      post recordqleits_url, params: { recordqleit: { monto: @recordqleit.monto, n1: @recordqleit.n1, ticket_id: @recordqleit.ticket_id } }
    end

    assert_redirected_to recordqleit_url(Recordqleit.last)
  end

  test "should show recordqleit" do
    get recordqleit_url(@recordqleit)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordqleit_url(@recordqleit)
    assert_response :success
  end

  test "should update recordqleit" do
    patch recordqleit_url(@recordqleit), params: { recordqleit: { monto: @recordqleit.monto, n1: @recordqleit.n1, ticket_id: @recordqleit.ticket_id } }
    assert_redirected_to recordqleit_url(@recordqleit)
  end

  test "should destroy recordqleit" do
    assert_difference('Recordqleit.count', -1) do
      delete recordqleit_url(@recordqleit)
    end

    assert_redirected_to recordqleits_url
  end
end
