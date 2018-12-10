require 'test_helper'

class RecordqnyttsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordqnytt = recordqnytts(:one)
  end

  test "should get index" do
    get recordqnytts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordqnytt_url
    assert_response :success
  end

  test "should create recordqnytt" do
    assert_difference('Recordqnytt.count') do
      post recordqnytts_url, params: { recordqnytt: { monto: @recordqnytt.monto, n1: @recordqnytt.n1, ticket_id: @recordqnytt.ticket_id } }
    end

    assert_redirected_to recordqnytt_url(Recordqnytt.last)
  end

  test "should show recordqnytt" do
    get recordqnytt_url(@recordqnytt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordqnytt_url(@recordqnytt)
    assert_response :success
  end

  test "should update recordqnytt" do
    patch recordqnytt_url(@recordqnytt), params: { recordqnytt: { monto: @recordqnytt.monto, n1: @recordqnytt.n1, ticket_id: @recordqnytt.ticket_id } }
    assert_redirected_to recordqnytt_url(@recordqnytt)
  end

  test "should destroy recordqnytt" do
    assert_difference('Recordqnytt.count', -1) do
      delete recordqnytt_url(@recordqnytt)
    end

    assert_redirected_to recordqnytts_url
  end
end
