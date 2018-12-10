require 'test_helper'

class RecordpnntsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordpnnt = recordpnnts(:one)
  end

  test "should get index" do
    get recordpnnts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordpnnt_url
    assert_response :success
  end

  test "should create recordpnnt" do
    assert_difference('Recordpnnt.count') do
      post recordpnnts_url, params: { recordpnnt: { monto: @recordpnnt.monto, n1: @recordpnnt.n1, n2: @recordpnnt.n2, siglas: @recordpnnt.siglas, ticket_id: @recordpnnt.ticket_id } }
    end

    assert_redirected_to recordpnnt_url(Recordpnnt.last)
  end

  test "should show recordpnnt" do
    get recordpnnt_url(@recordpnnt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordpnnt_url(@recordpnnt)
    assert_response :success
  end

  test "should update recordpnnt" do
    patch recordpnnt_url(@recordpnnt), params: { recordpnnt: { monto: @recordpnnt.monto, n1: @recordpnnt.n1, n2: @recordpnnt.n2, siglas: @recordpnnt.siglas, ticket_id: @recordpnnt.ticket_id } }
    assert_redirected_to recordpnnt_url(@recordpnnt)
  end

  test "should destroy recordpnnt" do
    assert_difference('Recordpnnt.count', -1) do
      delete recordpnnt_url(@recordpnnt)
    end

    assert_redirected_to recordpnnts_url
  end
end
