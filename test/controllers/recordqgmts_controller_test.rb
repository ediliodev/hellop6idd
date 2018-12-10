require 'test_helper'

class RecordqgmtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordqgmt = recordqgmts(:one)
  end

  test "should get index" do
    get recordqgmts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordqgmt_url
    assert_response :success
  end

  test "should create recordqgmt" do
    assert_difference('Recordqgmt.count') do
      post recordqgmts_url, params: { recordqgmt: { monto: @recordqgmt.monto, n1: @recordqgmt.n1, ticket_id: @recordqgmt.ticket_id } }
    end

    assert_redirected_to recordqgmt_url(Recordqgmt.last)
  end

  test "should show recordqgmt" do
    get recordqgmt_url(@recordqgmt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordqgmt_url(@recordqgmt)
    assert_response :success
  end

  test "should update recordqgmt" do
    patch recordqgmt_url(@recordqgmt), params: { recordqgmt: { monto: @recordqgmt.monto, n1: @recordqgmt.n1, ticket_id: @recordqgmt.ticket_id } }
    assert_redirected_to recordqgmt_url(@recordqgmt)
  end

  test "should destroy recordqgmt" do
    assert_difference('Recordqgmt.count', -1) do
      delete recordqgmt_url(@recordqgmt)
    end

    assert_redirected_to recordqgmts_url
  end
end
