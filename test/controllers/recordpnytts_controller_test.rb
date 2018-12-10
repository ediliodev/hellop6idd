require 'test_helper'

class RecordpnyttsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordpnytt = recordpnytts(:one)
  end

  test "should get index" do
    get recordpnytts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordpnytt_url
    assert_response :success
  end

  test "should create recordpnytt" do
    assert_difference('Recordpnytt.count') do
      post recordpnytts_url, params: { recordpnytt: { monto: @recordpnytt.monto, n1: @recordpnytt.n1, n2: @recordpnytt.n2, siglas: @recordpnytt.siglas, ticket_id: @recordpnytt.ticket_id } }
    end

    assert_redirected_to recordpnytt_url(Recordpnytt.last)
  end

  test "should show recordpnytt" do
    get recordpnytt_url(@recordpnytt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordpnytt_url(@recordpnytt)
    assert_response :success
  end

  test "should update recordpnytt" do
    patch recordpnytt_url(@recordpnytt), params: { recordpnytt: { monto: @recordpnytt.monto, n1: @recordpnytt.n1, n2: @recordpnytt.n2, siglas: @recordpnytt.siglas, ticket_id: @recordpnytt.ticket_id } }
    assert_redirected_to recordpnytt_url(@recordpnytt)
  end

  test "should destroy recordpnytt" do
    assert_difference('Recordpnytt.count', -1) do
      delete recordpnytt_url(@recordpnytt)
    end

    assert_redirected_to recordpnytts_url
  end
end
