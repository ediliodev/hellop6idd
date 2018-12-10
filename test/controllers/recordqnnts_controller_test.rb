require 'test_helper'

class RecordqnntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordqnnt = recordqnnts(:one)
  end

  test "should get index" do
    get recordqnnts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordqnnt_url
    assert_response :success
  end

  test "should create recordqnnt" do
    assert_difference('Recordqnnt.count') do
      post recordqnnts_url, params: { recordqnnt: { monto: @recordqnnt.monto, n1: @recordqnnt.n1, ticket_id: @recordqnnt.ticket_id } }
    end

    assert_redirected_to recordqnnt_url(Recordqnnt.last)
  end

  test "should show recordqnnt" do
    get recordqnnt_url(@recordqnnt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordqnnt_url(@recordqnnt)
    assert_response :success
  end

  test "should update recordqnnt" do
    patch recordqnnt_url(@recordqnnt), params: { recordqnnt: { monto: @recordqnnt.monto, n1: @recordqnnt.n1, ticket_id: @recordqnnt.ticket_id } }
    assert_redirected_to recordqnnt_url(@recordqnnt)
  end

  test "should destroy recordqnnt" do
    assert_difference('Recordqnnt.count', -1) do
      delete recordqnnt_url(@recordqnnt)
    end

    assert_redirected_to recordqnnts_url
  end
end
