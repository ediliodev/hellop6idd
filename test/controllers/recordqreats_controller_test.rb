require 'test_helper'

class RecordqreatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordqreat = recordqreats(:one)
  end

  test "should get index" do
    get recordqreats_url
    assert_response :success
  end

  test "should get new" do
    get new_recordqreat_url
    assert_response :success
  end

  test "should create recordqreat" do
    assert_difference('Recordqreat.count') do
      post recordqreats_url, params: { recordqreat: { monto: @recordqreat.monto, n1: @recordqreat.n1, ticket_id: @recordqreat.ticket_id } }
    end

    assert_redirected_to recordqreat_url(Recordqreat.last)
  end

  test "should show recordqreat" do
    get recordqreat_url(@recordqreat)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordqreat_url(@recordqreat)
    assert_response :success
  end

  test "should update recordqreat" do
    patch recordqreat_url(@recordqreat), params: { recordqreat: { monto: @recordqreat.monto, n1: @recordqreat.n1, ticket_id: @recordqreat.ticket_id } }
    assert_redirected_to recordqreat_url(@recordqreat)
  end

  test "should destroy recordqreat" do
    assert_difference('Recordqreat.count', -1) do
      delete recordqreat_url(@recordqreat)
    end

    assert_redirected_to recordqreats_url
  end
end
