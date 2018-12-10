require 'test_helper'

class RecordpnyntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordpnynt = recordpnynts(:one)
  end

  test "should get index" do
    get recordpnynts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordpnynt_url
    assert_response :success
  end

  test "should create recordpnynt" do
    assert_difference('Recordpnynt.count') do
      post recordpnynts_url, params: { recordpnynt: { monto: @recordpnynt.monto, n1: @recordpnynt.n1, n2: @recordpnynt.n2, siglas: @recordpnynt.siglas, ticket_id: @recordpnynt.ticket_id } }
    end

    assert_redirected_to recordpnynt_url(Recordpnynt.last)
  end

  test "should show recordpnynt" do
    get recordpnynt_url(@recordpnynt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordpnynt_url(@recordpnynt)
    assert_response :success
  end

  test "should update recordpnynt" do
    patch recordpnynt_url(@recordpnynt), params: { recordpnynt: { monto: @recordpnynt.monto, n1: @recordpnynt.n1, n2: @recordpnynt.n2, siglas: @recordpnynt.siglas, ticket_id: @recordpnynt.ticket_id } }
    assert_redirected_to recordpnynt_url(@recordpnynt)
  end

  test "should destroy recordpnynt" do
    assert_difference('Recordpnynt.count', -1) do
      delete recordpnynt_url(@recordpnynt)
    end

    assert_redirected_to recordpnynts_url
  end
end
