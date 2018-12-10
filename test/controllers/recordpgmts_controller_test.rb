require 'test_helper'

class RecordpgmtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordpgmt = recordpgmts(:one)
  end

  test "should get index" do
    get recordpgmts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordpgmt_url
    assert_response :success
  end

  test "should create recordpgmt" do
    assert_difference('Recordpgmt.count') do
      post recordpgmts_url, params: { recordpgmt: { monto: @recordpgmt.monto, n1: @recordpgmt.n1, n2: @recordpgmt.n2, siglas: @recordpgmt.siglas, ticket_id: @recordpgmt.ticket_id } }
    end

    assert_redirected_to recordpgmt_url(Recordpgmt.last)
  end

  test "should show recordpgmt" do
    get recordpgmt_url(@recordpgmt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordpgmt_url(@recordpgmt)
    assert_response :success
  end

  test "should update recordpgmt" do
    patch recordpgmt_url(@recordpgmt), params: { recordpgmt: { monto: @recordpgmt.monto, n1: @recordpgmt.n1, n2: @recordpgmt.n2, siglas: @recordpgmt.siglas, ticket_id: @recordpgmt.ticket_id } }
    assert_redirected_to recordpgmt_url(@recordpgmt)
  end

  test "should destroy recordpgmt" do
    assert_difference('Recordpgmt.count', -1) do
      delete recordpgmt_url(@recordpgmt)
    end

    assert_redirected_to recordpgmts_url
  end
end
