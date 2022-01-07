require 'test_helper'

class RecordspltknntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordspltknnt = recordspltknnts(:one)
  end

  test "should get index" do
    get recordspltknnts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordspltknnt_url
    assert_response :success
  end

  test "should create recordspltknnt" do
    assert_difference('Recordspltknnt.count') do
      post recordspltknnts_url, params: { recordspltknnt: { monto: @recordspltknnt.monto, n1: @recordspltknnt.n1, n2: @recordspltknnt.n2, siglas: @recordspltknnt.siglas, ticket_id: @recordspltknnt.ticket_id } }
    end

    assert_redirected_to recordspltknnt_url(Recordspltknnt.last)
  end

  test "should show recordspltknnt" do
    get recordspltknnt_url(@recordspltknnt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordspltknnt_url(@recordspltknnt)
    assert_response :success
  end

  test "should update recordspltknnt" do
    patch recordspltknnt_url(@recordspltknnt), params: { recordspltknnt: { monto: @recordspltknnt.monto, n1: @recordspltknnt.n1, n2: @recordspltknnt.n2, siglas: @recordspltknnt.siglas, ticket_id: @recordspltknnt.ticket_id } }
    assert_redirected_to recordspltknnt_url(@recordspltknnt)
  end

  test "should destroy recordspltknnt" do
    assert_difference('Recordspltknnt.count', -1) do
      delete recordspltknnt_url(@recordspltknnt)
    end

    assert_redirected_to recordspltknnts_url
  end
end
