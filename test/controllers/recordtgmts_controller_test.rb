require 'test_helper'

class RecordtgmtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordtgmt = recordtgmts(:one)
  end

  test "should get index" do
    get recordtgmts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordtgmt_url
    assert_response :success
  end

  test "should create recordtgmt" do
    assert_difference('Recordtgmt.count') do
      post recordtgmts_url, params: { recordtgmt: { monto: @recordtgmt.monto, n1: @recordtgmt.n1, n2: @recordtgmt.n2, n3: @recordtgmt.n3, seleccionada: @recordtgmt.seleccionada, siglas: @recordtgmt.siglas, ticket_id: @recordtgmt.ticket_id } }
    end

    assert_redirected_to recordtgmt_url(Recordtgmt.last)
  end

  test "should show recordtgmt" do
    get recordtgmt_url(@recordtgmt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordtgmt_url(@recordtgmt)
    assert_response :success
  end

  test "should update recordtgmt" do
    patch recordtgmt_url(@recordtgmt), params: { recordtgmt: { monto: @recordtgmt.monto, n1: @recordtgmt.n1, n2: @recordtgmt.n2, n3: @recordtgmt.n3, seleccionada: @recordtgmt.seleccionada, siglas: @recordtgmt.siglas, ticket_id: @recordtgmt.ticket_id } }
    assert_redirected_to recordtgmt_url(@recordtgmt)
  end

  test "should destroy recordtgmt" do
    assert_difference('Recordtgmt.count', -1) do
      delete recordtgmt_url(@recordtgmt)
    end

    assert_redirected_to recordtgmts_url
  end
end
