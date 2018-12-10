require 'test_helper'

class RecordtnyttsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordtnytt = recordtnytts(:one)
  end

  test "should get index" do
    get recordtnytts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordtnytt_url
    assert_response :success
  end

  test "should create recordtnytt" do
    assert_difference('Recordtnytt.count') do
      post recordtnytts_url, params: { recordtnytt: { monto: @recordtnytt.monto, n1: @recordtnytt.n1, n2: @recordtnytt.n2, n3: @recordtnytt.n3, seleccionada: @recordtnytt.seleccionada, siglas: @recordtnytt.siglas, ticket_id: @recordtnytt.ticket_id } }
    end

    assert_redirected_to recordtnytt_url(Recordtnytt.last)
  end

  test "should show recordtnytt" do
    get recordtnytt_url(@recordtnytt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordtnytt_url(@recordtnytt)
    assert_response :success
  end

  test "should update recordtnytt" do
    patch recordtnytt_url(@recordtnytt), params: { recordtnytt: { monto: @recordtnytt.monto, n1: @recordtnytt.n1, n2: @recordtnytt.n2, n3: @recordtnytt.n3, seleccionada: @recordtnytt.seleccionada, siglas: @recordtnytt.siglas, ticket_id: @recordtnytt.ticket_id } }
    assert_redirected_to recordtnytt_url(@recordtnytt)
  end

  test "should destroy recordtnytt" do
    assert_difference('Recordtnytt.count', -1) do
      delete recordtnytt_url(@recordtnytt)
    end

    assert_redirected_to recordtnytts_url
  end
end
