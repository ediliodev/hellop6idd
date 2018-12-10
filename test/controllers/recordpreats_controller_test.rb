require 'test_helper'

class RecordpreatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordpreat = recordpreats(:one)
  end

  test "should get index" do
    get recordpreats_url
    assert_response :success
  end

  test "should get new" do
    get new_recordpreat_url
    assert_response :success
  end

  test "should create recordpreat" do
    assert_difference('Recordpreat.count') do
      post recordpreats_url, params: { recordpreat: { monto: @recordpreat.monto, n1: @recordpreat.n1, n2: @recordpreat.n2, siglas: @recordpreat.siglas, ticket_id: @recordpreat.ticket_id } }
    end

    assert_redirected_to recordpreat_url(Recordpreat.last)
  end

  test "should show recordpreat" do
    get recordpreat_url(@recordpreat)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordpreat_url(@recordpreat)
    assert_response :success
  end

  test "should update recordpreat" do
    patch recordpreat_url(@recordpreat), params: { recordpreat: { monto: @recordpreat.monto, n1: @recordpreat.n1, n2: @recordpreat.n2, siglas: @recordpreat.siglas, ticket_id: @recordpreat.ticket_id } }
    assert_redirected_to recordpreat_url(@recordpreat)
  end

  test "should destroy recordpreat" do
    assert_difference('Recordpreat.count', -1) do
      delete recordpreat_url(@recordpreat)
    end

    assert_redirected_to recordpreats_url
  end
end
