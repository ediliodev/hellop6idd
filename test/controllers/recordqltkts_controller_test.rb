require 'test_helper'

class RecordqltktsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordqltkt = recordqltkts(:one)
  end

  test "should get index" do
    get recordqltkts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordqltkt_url
    assert_response :success
  end

  test "should create recordqltkt" do
    assert_difference('Recordqltkt.count') do
      post recordqltkts_url, params: { recordqltkt: { monto: @recordqltkt.monto, n1: @recordqltkt.n1, ticket_id: @recordqltkt.ticket_id } }
    end

    assert_redirected_to recordqltkt_url(Recordqltkt.last)
  end

  test "should show recordqltkt" do
    get recordqltkt_url(@recordqltkt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordqltkt_url(@recordqltkt)
    assert_response :success
  end

  test "should update recordqltkt" do
    patch recordqltkt_url(@recordqltkt), params: { recordqltkt: { monto: @recordqltkt.monto, n1: @recordqltkt.n1, ticket_id: @recordqltkt.ticket_id } }
    assert_redirected_to recordqltkt_url(@recordqltkt)
  end

  test "should destroy recordqltkt" do
    assert_difference('Recordqltkt.count', -1) do
      delete recordqltkt_url(@recordqltkt)
    end

    assert_redirected_to recordqltkts_url
  end
end
