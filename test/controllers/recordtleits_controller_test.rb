require 'test_helper'

class RecordtleitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recordtleit = recordtleits(:one)
  end

  test "should get index" do
    get recordtleits_url
    assert_response :success
  end

  test "should get new" do
    get new_recordtleit_url
    assert_response :success
  end

  test "should create recordtleit" do
    assert_difference('Recordtleit.count') do
      post recordtleits_url, params: { recordtleit: { monto: @recordtleit.monto, n1: @recordtleit.n1, n2: @recordtleit.n2, n3: @recordtleit.n3, seleccionada: @recordtleit.seleccionada, siglas: @recordtleit.siglas, ticket_id: @recordtleit.ticket_id } }
    end

    assert_redirected_to recordtleit_url(Recordtleit.last)
  end

  test "should show recordtleit" do
    get recordtleit_url(@recordtleit)
    assert_response :success
  end

  test "should get edit" do
    get edit_recordtleit_url(@recordtleit)
    assert_response :success
  end

  test "should update recordtleit" do
    patch recordtleit_url(@recordtleit), params: { recordtleit: { monto: @recordtleit.monto, n1: @recordtleit.n1, n2: @recordtleit.n2, n3: @recordtleit.n3, seleccionada: @recordtleit.seleccionada, siglas: @recordtleit.siglas, ticket_id: @recordtleit.ticket_id } }
    assert_redirected_to recordtleit_url(@recordtleit)
  end

  test "should destroy recordtleit" do
    assert_difference('Recordtleit.count', -1) do
      delete recordtleit_url(@recordtleit)
    end

    assert_redirected_to recordtleits_url
  end
end
