require 'test_helper'

class RecordspnntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordspnnt = recordspnnts(:one)
  end

  test "should get index" do
    get recordspnnts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordspnnt_url
    assert_response :success
  end

  test "should create recordspnnt" do
    assert_difference('Recordspnnt.count') do
      post recordspnnts_url, params: { recordspnnt: { monto: @recordspnnt.monto, n1: @recordspnnt.n1, n2: @recordspnnt.n2, siglas: @recordspnnt.siglas, ticket_id: @recordspnnt.ticket_id } }
    end

    assert_redirected_to recordspnnt_url(Recordspnnt.last)
  end

  test "should show recordspnnt" do
    get recordspnnt_url(@recordspnnt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordspnnt_url(@recordspnnt)
    assert_response :success
  end

  test "should update recordspnnt" do
    patch recordspnnt_url(@recordspnnt), params: { recordspnnt: { monto: @recordspnnt.monto, n1: @recordspnnt.n1, n2: @recordspnnt.n2, siglas: @recordspnnt.siglas, ticket_id: @recordspnnt.ticket_id } }
    assert_redirected_to recordspnnt_url(@recordspnnt)
  end

  test "should destroy recordspnnt" do
    assert_difference('Recordspnnt.count', -1) do
      delete recordspnnt_url(@recordspnnt)
    end

    assert_redirected_to recordspnnts_url
  end
end
