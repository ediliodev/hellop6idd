require 'test_helper'

class RecordpleitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordpleit = recordpleits(:one)
  end

  test "should get index" do
    get recordpleits_url
    assert_response :success
  end

  test "should get new" do
    get new_recordpleit_url
    assert_response :success
  end

  test "should create recordpleit" do
    assert_difference('Recordpleit.count') do
      post recordpleits_url, params: { recordpleit: { monto: @recordpleit.monto, n1: @recordpleit.n1, n2: @recordpleit.n2, siglas: @recordpleit.siglas, ticket_id: @recordpleit.ticket_id } }
    end

    assert_redirected_to recordpleit_url(Recordpleit.last)
  end

  test "should show recordpleit" do
    get recordpleit_url(@recordpleit)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordpleit_url(@recordpleit)
    assert_response :success
  end

  test "should update recordpleit" do
    patch recordpleit_url(@recordpleit), params: { recordpleit: { monto: @recordpleit.monto, n1: @recordpleit.n1, n2: @recordpleit.n2, siglas: @recordpleit.siglas, ticket_id: @recordpleit.ticket_id } }
    assert_redirected_to recordpleit_url(@recordpleit)
  end

  test "should destroy recordpleit" do
    assert_difference('Recordpleit.count', -1) do
      delete recordpleit_url(@recordpleit)
    end

    assert_redirected_to recordpleits_url
  end
end
