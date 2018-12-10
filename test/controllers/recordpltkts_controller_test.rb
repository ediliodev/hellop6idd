require 'test_helper'

class RecordpltktsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordpltkt = recordpltkts(:one)
  end

  test "should get index" do
    get recordpltkts_url
    assert_response :success
  end

  test "should get new" do
    get new_recordpltkt_url
    assert_response :success
  end

  test "should create recordpltkt" do
    assert_difference('Recordpltkt.count') do
      post recordpltkts_url, params: { recordpltkt: { monto: @recordpltkt.monto, n1: @recordpltkt.n1, n2: @recordpltkt.n2, siglas: @recordpltkt.siglas, ticket_id: @recordpltkt.ticket_id } }
    end

    assert_redirected_to recordpltkt_url(Recordpltkt.last)
  end

  test "should show recordpltkt" do
    get recordpltkt_url(@recordpltkt)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordpltkt_url(@recordpltkt)
    assert_response :success
  end

  test "should update recordpltkt" do
    patch recordpltkt_url(@recordpltkt), params: { recordpltkt: { monto: @recordpltkt.monto, n1: @recordpltkt.n1, n2: @recordpltkt.n2, siglas: @recordpltkt.siglas, ticket_id: @recordpltkt.ticket_id } }
    assert_redirected_to recordpltkt_url(@recordpltkt)
  end

  test "should destroy recordpltkt" do
    assert_difference('Recordpltkt.count', -1) do
      delete recordpltkt_url(@recordpltkt)
    end

    assert_redirected_to recordpltkts_url
  end
end
