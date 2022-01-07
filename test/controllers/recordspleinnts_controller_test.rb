require 'test_helper'

class RecordspleinntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordspleinnt = recordspleinnts(:one)
  end

  test "should get index" do
    get recordspleinnts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordspleinnt_url
    assert_response :success
  end

  test "should create recordspleinnt" do
    assert_difference('Recordspleinnt.count') do
      post recordspleinnts_url, params: { recordspleinnt: { monto: @recordspleinnt.monto, n1: @recordspleinnt.n1, n2: @recordspleinnt.n2, siglas: @recordspleinnt.siglas, ticket_id: @recordspleinnt.ticket_id } }
    end

    assert_redirected_to recordspleinnt_url(Recordspleinnt.last)
  end

  test "should show recordspleinnt" do
    get recordspleinnt_url(@recordspleinnt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordspleinnt_url(@recordspleinnt)
    assert_response :success
  end

  test "should update recordspleinnt" do
    patch recordspleinnt_url(@recordspleinnt), params: { recordspleinnt: { monto: @recordspleinnt.monto, n1: @recordspleinnt.n1, n2: @recordspleinnt.n2, siglas: @recordspleinnt.siglas, ticket_id: @recordspleinnt.ticket_id } }
    assert_redirected_to recordspleinnt_url(@recordspleinnt)
  end

  test "should destroy recordspleinnt" do
    assert_difference('Recordspleinnt.count', -1) do
      delete recordspleinnt_url(@recordspleinnt)
    end

    assert_redirected_to recordspleinnts_url
  end
end
