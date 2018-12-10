require 'test_helper'

class RecordtltktsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordtltkt = recordtltkts(:one)
  end

  test "should get index" do
    get recordtltkts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordtltkt_url
    assert_response :success
  end

  test "should create recordtltkt" do
    assert_difference('Recordtltkt.count') do
      post recordtltkts_url, params: { recordtltkt: { monto: @recordtltkt.monto, n1: @recordtltkt.n1, n2: @recordtltkt.n2, n3: @recordtltkt.n3, seleccionada: @recordtltkt.seleccionada, siglas: @recordtltkt.siglas, ticket_id: @recordtltkt.ticket_id } }
    end

    assert_redirected_to recordtltkt_url(Recordtltkt.last)
  end

  test "should show recordtltkt" do
    get recordtltkt_url(@recordtltkt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordtltkt_url(@recordtltkt)
    assert_response :success
  end

  test "should update recordtltkt" do
    patch recordtltkt_url(@recordtltkt), params: { recordtltkt: { monto: @recordtltkt.monto, n1: @recordtltkt.n1, n2: @recordtltkt.n2, n3: @recordtltkt.n3, seleccionada: @recordtltkt.seleccionada, siglas: @recordtltkt.siglas, ticket_id: @recordtltkt.ticket_id } }
    assert_redirected_to recordtltkt_url(@recordtltkt)
  end

  test "should destroy recordtltkt" do
    assert_difference('Recordtltkt.count', -1) do
      delete recordtltkt_url(@recordtltkt)
    end

    assert_redirected_to recordtltkts_url
  end
end
