require 'test_helper'

class RecordtnntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordtnnt = recordtnnts(:one)
  end

  test "should get index" do
    get recordtnnts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordtnnt_url
    assert_response :success
  end

  test "should create recordtnnt" do
    assert_difference('Recordtnnt.count') do
      post recordtnnts_url, params: { recordtnnt: { monto: @recordtnnt.monto, n1: @recordtnnt.n1, n2: @recordtnnt.n2, n3: @recordtnnt.n3, siglas: @recordtnnt.siglas, ticket_id: @recordtnnt.ticket_id } }
    end

    assert_redirected_to recordtnnt_url(Recordtnnt.last)
  end

  test "should show recordtnnt" do
    get recordtnnt_url(@recordtnnt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordtnnt_url(@recordtnnt)
    assert_response :success
  end

  test "should update recordtnnt" do
    patch recordtnnt_url(@recordtnnt), params: { recordtnnt: { monto: @recordtnnt.monto, n1: @recordtnnt.n1, n2: @recordtnnt.n2, n3: @recordtnnt.n3, siglas: @recordtnnt.siglas, ticket_id: @recordtnnt.ticket_id } }
    assert_redirected_to recordtnnt_url(@recordtnnt)
  end

  test "should destroy recordtnnt" do
    assert_difference('Recordtnnt.count', -1) do
      delete recordtnnt_url(@recordtnnt)
    end

    assert_redirected_to recordtnnts_url
  end
end
