require 'test_helper'

class RecordqnyntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordqnynt = recordqnynts(:one)
  end

  test "should get index" do
    get recordqnynts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordqnynt_url
    assert_response :success
  end

  test "should create recordqnynt" do
    assert_difference('Recordqnynt.count') do
      post recordqnynts_url, params: { recordqnynt: { monto: @recordqnynt.monto, n1: @recordqnynt.n1, ticket_id: @recordqnynt.ticket_id } }
    end

    assert_redirected_to recordqnynt_url(Recordqnynt.last)
  end

  test "should show recordqnynt" do
    get recordqnynt_url(@recordqnynt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordqnynt_url(@recordqnynt)
    assert_response :success
  end

  test "should update recordqnynt" do
    patch recordqnynt_url(@recordqnynt), params: { recordqnynt: { monto: @recordqnynt.monto, n1: @recordqnynt.n1, ticket_id: @recordqnynt.ticket_id } }
    assert_redirected_to recordqnynt_url(@recordqnynt)
  end

  test "should destroy recordqnynt" do
    assert_difference('Recordqnynt.count', -1) do
      delete recordqnynt_url(@recordqnynt)
    end

    assert_redirected_to recordqnynts_url
  end
end
