require 'test_helper'

class RecordtreatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordtreat = recordtreats(:one)
  end

  test "should get index" do
    get recordtreats_url
    assert_response :success
  end

  test "should get new" do
    get new_recordtreat_url
    assert_response :success
  end

  test "should create recordtreat" do
    assert_difference('Recordtreat.count') do
      post recordtreats_url, params: { recordtreat: { monto: @recordtreat.monto, n1: @recordtreat.n1, n2: @recordtreat.n2, n3: @recordtreat.n3, seleccionada: @recordtreat.seleccionada, siglas: @recordtreat.siglas, ticket_id: @recordtreat.ticket_id } }
    end

    assert_redirected_to recordtreat_url(Recordtreat.last)
  end

  test "should show recordtreat" do
    get recordtreat_url(@recordtreat)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordtreat_url(@recordtreat)
    assert_response :success
  end

  test "should update recordtreat" do
    patch recordtreat_url(@recordtreat), params: { recordtreat: { monto: @recordtreat.monto, n1: @recordtreat.n1, n2: @recordtreat.n2, n3: @recordtreat.n3, seleccionada: @recordtreat.seleccionada, siglas: @recordtreat.siglas, ticket_id: @recordtreat.ticket_id } }
    assert_redirected_to recordtreat_url(@recordtreat)
  end

  test "should destroy recordtreat" do
    assert_difference('Recordtreat.count', -1) do
      delete recordtreat_url(@recordtreat)
    end

    assert_redirected_to recordtreats_url
  end
end
