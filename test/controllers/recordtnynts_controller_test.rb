require 'test_helper'

class RecordtnyntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordtnynt = recordtnynts(:one)
  end

  test "should get index" do
    get recordtnynts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordtnynt_url
    assert_response :success
  end

  test "should create recordtnynt" do
    assert_difference('Recordtnynt.count') do
      post recordtnynts_url, params: { recordtnynt: { monto: @recordtnynt.monto, n1: @recordtnynt.n1, n2: @recordtnynt.n2, n3: @recordtnynt.n3, seleccionada: @recordtnynt.seleccionada, siglas: @recordtnynt.siglas, ticket_id: @recordtnynt.ticket_id } }
    end

    assert_redirected_to recordtnynt_url(Recordtnynt.last)
  end

  test "should show recordtnynt" do
    get recordtnynt_url(@recordtnynt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordtnynt_url(@recordtnynt)
    assert_response :success
  end

  test "should update recordtnynt" do
    patch recordtnynt_url(@recordtnynt), params: { recordtnynt: { monto: @recordtnynt.monto, n1: @recordtnynt.n1, n2: @recordtnynt.n2, n3: @recordtnynt.n3, seleccionada: @recordtnynt.seleccionada, siglas: @recordtnynt.siglas, ticket_id: @recordtnynt.ticket_id } }
    assert_redirected_to recordtnynt_url(@recordtnynt)
  end

  test "should destroy recordtnynt" do
    assert_difference('Recordtnynt.count', -1) do
      delete recordtnynt_url(@recordtnynt)
    end

    assert_redirected_to recordtnynts_url
  end
end
